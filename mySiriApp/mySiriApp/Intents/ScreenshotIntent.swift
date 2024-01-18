//
//  ScreenshotIntent.swift
//  mySiriApp
//
//  Created by POU LIN on 2024/1/18.
//

import Foundation
import AppIntents
import SwiftUI

struct ScreenshotIntent: AppIntent {
    static let title: LocalizedStringResource = "Screenshot now"
    
    static let openAppWhenRun: Bool = true
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        let screen = saveScreenshow()
        return .result(dialog: "Go", view: SnippetView(render: screen))
    }
    
    func saveScreenshow() -> UIImage {
        let screenshotDirectoryURL = URL(filePath: "/Users/peterpan/Desktop/preview/")
        
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = scene?.keyWindow ?? UIWindow(frame: .zero)
        let renderer = UIGraphicsImageRenderer(size: window.bounds.size)
        let image = renderer.image { context in
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }
        let pngData = image.pngData()
        let screenshotURL = screenshotDirectoryURL.appending(path: "\(UUID())").appendingPathExtension(for: .png)
        try? image.pngData()?.write(to: screenshotURL)
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        return image
    }
}
