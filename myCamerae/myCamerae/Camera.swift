//
//  Camera.swift
//  myCamerae
//
//  Created by POU LIN on 2023/10/19.
//

import Foundation
import AVFoundation

class Camera {
    let captureSession = AVCaptureSession()
    
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
        #if os(visionOS)
        let captureDevice = AVCaptureDevice.systemPreferredCamera
        #else
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        #endif
        do {
            // Wrap the audio device in a capture device input.
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            // If the input can be added, add it to the session.
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch {
            // Configuration failed. Handle error.
            print("Failed to set input device with error: \(error)")
        }
        
        let output = AVCaptureVideoDataOutput()
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
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
        captureSession.stopRunning()
    }
}
