//
//  MyWebView.swift
//  wakeupApp
//
//  Created by POU LIN on 2024/1/10.
//
import SwiftUI
import WebKit
 
struct MyWebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
