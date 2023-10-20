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
    
    private var videoDataOutput:AVCaptureVideoDataOutput!
    
//    private var connection:AVCaptureConnection!
    
    private var videoWriterInput : AVAssetWriterInput!
    
    private var audioWriterInput :AVAssetWriterInput!
    
    private var sessionAtSourceTime :CMTime?
    
//    init(videoWriter: AVAssetWriter, isRecording: Bool, videoDataOutput: AVCaptureVideoDataOutput, connection: AVCaptureConnection, videoWriterInput: AVAssetWriterInput, audioWriterInput: AVAssetWriterInput) {
//        self.videoWriter = videoWriter
//        self.isRecording = isRecording
//        self.videoDataOutput = videoDataOutput
//        self.connection = connection
//        self.videoWriterInput = videoWriterInput
//        self.audioWriterInput = audioWriterInput
//    }
    
//    init(videoWriter: AVAssetWriter, isRecording: Bool, videoDataOutput: AVCaptureVideoDataOutput, connection: AVCaptureConnection, videoWriterInput: AVAssetWriterInput) {
//        self.videoWriter = videoWriter
//        self.isRecording = isRecording
//        self.videoDataOutput = videoDataOutput
//        self.connection = connection
//        self.videoWriterInput = videoWriterInput
//    }
    
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
    
    private func setupCaptureSession() {
        setUpWriter()
#if os(visionOS)
        let captureDevice = AVCaptureDevice.systemPreferredCamera
#else
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
#endif
        captureSession.beginConfiguration()
        do {
            // Wrap the audio device in a capture device input.
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            // If the input can be added, add it to the session.
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                print("device intput added")
            }
        } catch {
            // Configuration failed. Handle error.
            print("Failed to set input device with error: \(error)")
        }
        
        captureSession.commitConfiguration()
        
        videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "poulin.myCamerae"))
        captureSession.beginConfiguration()
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
            print("video data output added")
        }
        captureSession.commitConfiguration()
//        connection = videoDataOutput.connection(with: .video)
        
        
        //        let cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //        cameraLayer.frame = self.view.frame
        
        captureSession.startRunning()
    }
    //    let captureSession = AVCaptureSession()
    
    //    func config() {
    //
    //        // Find the default audio device.
    //        #if os(visionOS)
    //        var audioDevice:AVCaptureDevice?
    //        if AVCaptureDevice.authorizationStatus(for: .video) != AVAuthorizationStatus.authorized {
    //            AVCaptureDevice.requestAccess(for: .video) { Bool in
    //                if Bool == true {
    //                    print("got access")
    //                }else {
    //                    print("access deind")
    //                }
    //            }
    //            return
    //        }else {
    //            audioDevice = AVCaptureDevice.systemPreferredCamera
    //        }
    //        #else
    //            guard let audioDevice = AVCaptureDevice.default(for: .video) else { return }
    //        #endif
    //        captureSession.beginConfiguration()
    //        do {
    //            // Wrap the audio device in a capture device input.
    //            let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
    //            // If the input can be added, add it to the session.
    //            if captureSession.canAddInput(audioInput) {
    //                captureSession.addInput(audioInput)
    //            }
    //        } catch {
    //            // Configuration failed. Handle error.
    //        }
    //
    //        captureSession.commitConfiguration()
    //    }
    //
    
    func close() {
        videoWriterInput.markAsFinished()
        videoWriter.finishWriting { [weak self] in
//            self?.sessionAtSourceTime = nil
            print("finish writing")
        }
        captureSession.stopRunning()
    }
    
    func setUpWriter() {
        do {
            let outputFileLocation = videoFileLocation()
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

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
//        var timestamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer).seconds
        let writable = canWrite()
        
        if writable,
           sessionAtSourceTime == nil {
            // start writing
            sessionAtSourceTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            videoWriter.startSession(atSourceTime: sessionAtSourceTime!)
            //print("Writing")
        }
        
        if output == videoDataOutput {
            //            connection.videoOrientation = .portrait
            
            if connection.isVideoMirroringSupported {
                connection.isVideoMirrored = true
            }
        }
        
        if writable,
           output == videoDataOutput,
           (videoWriterInput.isReadyForMoreMediaData) {
            // write video buffer
            videoWriterInput.append(sampleBuffer)
            //print("video buffering")
        }
//                else if writable,
//                          output == audioDataOutput,
//                          (audioWriterInput.isReadyForMoreMediaData) {
//                    // write audio buffer
//                    audioWriterInput?.append(sampleBuffer)
//                    //print("audio buffering")
//                }
    }
}
