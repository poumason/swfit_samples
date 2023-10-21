//
//  Camera.swift
//  myCamerae
//
//  Created by POU LIN on 2023/10/19.
//

import Foundation
import AVFoundation

class Camera : NSObject{
    let captureSession = AVCaptureSession()
    
    private var videoWriter: AVAssetWriter!
    
    private var isRecording:Bool!
    
    private var videoDataOutput: AVCaptureVideoDataOutput!
    
    #if !os(visionOS)
    private var audioDataOutput: AVCaptureAudioDataOutput!
    #endif
    
    private var videoWriterInput: AVAssetWriterInput!
    
    private var audioWriterInput: AVAssetWriterInput!
    
    private var sessionAtSourceTime: CMTime?
    
    private var uiQueue: DispatchQueue = DispatchQueue(label: "poulin.myCamerae")
    
    var outputFileLocation: URL!
    
    func open() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.setupCaptureSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted {
                    print("the user has granted to access the camera")
                    DispatchSerialQueue.main.async {
                        self.setupCaptureSession()
                    }
                }else {
                }
            }
        case .restricted:
            print("the user has denied proviously to access the camera")
        case .denied:
            print("the user can't give camera access due to some restriction")
        @unknown default:
            print("somethin has wrong due to we can't access the camerea.")
        }
    }
    
    private func enableVideo() {
#if os(visionOS)
        guard let captureDevice = AVCaptureDevice.systemPreferredCamera else { return }
#else
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
#endif
        do {
            // Wrap the audio device in a capture device input.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            // If the input can be added, add it to the session.
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                print("device intput added")
            }
        } catch {
            // Configuration failed. Handle error.
            print("Failed to set input device with error: \(error)")
        }
        
        videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: uiQueue)
        
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
            print("video data output added")
        }
    }
    
    private func enableAudio() {
        #if !os(visionOS)
        guard let captureDevice = AVCaptureDevice.default(for: .audio) else { return }
        do {
            // Wrap the audio device in a capture device input.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            // If the input can be added, add it to the session.
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                print("audio device intput added")
            }
        } catch {
            // Configuration failed. Handle error.
            print("Failed to set input device with error: \(error)")
        }
        
        audioDataOutput = AVCaptureAudioDataOutput()
        audioDataOutput.setSampleBufferDelegate(self, queue: uiQueue)
        
        if captureSession.canAddOutput(audioDataOutput) {
            captureSession.addOutput(audioDataOutput)
            print("audio data output added")
        }
        #endif
    }
    
    private func setupCaptureSession() {
        isRecording = true
        setUpWriter()
        captureSession.beginConfiguration()
        
        enableVideo()
        enableAudio()
        
        captureSession.commitConfiguration()
        
        captureSession.startRunning()
    }
    
    func close() {
        isRecording = false
        videoWriterInput.markAsFinished()
        videoWriter.finishWriting { [weak self] in
            self?.sessionAtSourceTime = nil
            print("finish writing")
        }
        captureSession.stopRunning()
    }
    
    func setUpWriter() {
        do {
            outputFileLocation = videoFileLocation()
            videoWriter = try AVAssetWriter(outputURL: outputFileLocation, fileType: AVFileType.mov)
            
            // add video input
            videoWriterInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: [
                AVVideoCodecKey : AVVideoCodecType.h264,
                AVVideoWidthKey : 720,
                AVVideoHeightKey : 1280,
                AVVideoCompressionPropertiesKey : [
                    AVVideoAverageBitRateKey : 2300000,
                ],
            ])
            
            videoWriterInput.expectsMediaDataInRealTime = true
            
            if videoWriter.canAdd(videoWriterInput) {
                videoWriter.add(videoWriterInput)
                print("video input added")
            } else {
                print("no input added")
            }
            
            // add audio input
            audioWriterInput = AVAssetWriterInput(mediaType: AVMediaType.audio, outputSettings: nil)
            audioWriterInput.expectsMediaDataInRealTime = true
            
            if videoWriter.canAdd(audioWriterInput) {
                videoWriter.add(audioWriterInput)
                print("audio input added")
            }
            
            videoWriter.startWriting()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    //video file location method
    func videoFileLocation() -> URL {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let videoOutputUrl = URL(fileURLWithPath: documentsPath.appendingPathComponent("videoFile")).appendingPathExtension("mov")
        do {
            if FileManager.default.fileExists(atPath: videoOutputUrl.path) {
                try FileManager.default.removeItem(at: videoOutputUrl)
                print("file removed")
            }
        } catch {
            print(error)
        }
        
        return videoOutputUrl
    }
    
    func canWrite() -> Bool {
        return isRecording && videoWriter != nil && videoWriter.status == .writing
    }
}

#if !os(visionOS)
extension Camera:  AVCaptureAudioDataOutputSampleBufferDelegate {
}
#endif

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let writable = canWrite()
        
        if writable == false {
            print("not avaiable to write")
            return
        }
        
        if sessionAtSourceTime == nil {
            // start writing
            sessionAtSourceTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            videoWriter.startSession(atSourceTime: sessionAtSourceTime!)
            //print("Writing")
        }
        
        if output == videoDataOutput {
#if !os(visionOS)
            connection.videoOrientation = .portrait
            if connection.isVideoMirroringSupported {
                connection.isVideoMirrored = true
            }
#endif
        }
        
//        let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)
        
        if output == videoDataOutput,
           (videoWriterInput.isReadyForMoreMediaData) {
            // write video buffer
            videoWriterInput.append(sampleBuffer)
            print("video buffering")
        }
#if !os(visionOS)
        if output == audioDataOutput,
           (audioWriterInput.isReadyForMoreMediaData) {
            // write audio buffer
            audioWriterInput?.append(sampleBuffer)
            print("audio buffering")
        }
#endif
    }
}
