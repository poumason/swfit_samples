//
//  DocumentScannerRepresentable.swift
//  vision_kit_app
//
//  Created by POU LIN on 2024/1/27.
//

import Foundation
import SwiftUI
import VisionKit
import Vision

struct DocumentScannerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = context.coordinator
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: DocumentScannerRepresentable
        
        init(parent: DocumentScannerRepresentable) {
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            var getPages = [UIImage]()
            
            for i in 0 ..< scan.pageCount {
                getPages.append(scan.imageOfPage(at: i))
            }
            
            parent.didFinishScanning(.success(getPages))
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            parent.didCancelScanning()
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            parent.didFinishScanning(.failure(error))
        }
    }
    
    
    var didFinishScanning: ((_ result: Result<[UIImage], Error>) -> Void)
    
    var didCancelScanning: () -> Void
}
