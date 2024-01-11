//
//  WebViewUI.swift
//  wakeupApp
//
//  Created by POU LIN on 2024/1/11.
//

import Foundation
import SwiftUI
import WebKit

struct WebViewUI: UIViewRepresentable {
    @Bindable var navigationState: NavigationState
    
    func makeUIView(context: Context) -> WKWebView {
        return navigationState.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
