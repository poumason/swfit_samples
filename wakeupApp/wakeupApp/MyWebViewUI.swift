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
    
    private let delgate: MyWKNavigation = MyWKNavigation()
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView.navigationDelegate = self.delgate
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

class MyWKNavigation: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        return WKNavigationActionPolicy.allow
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(navigation ?? "")
    }
}

// https://www.avanderlee.com/swiftui/sfsafariviewcontroller-open-webpages-in-app/
//
