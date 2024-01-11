//
//  NavigationState.swift
//  wakeupApp
//
//  Created by POU LIN on 2024/1/11.
//

import Foundation
import SwiftUI
import WebKit

@Observable
class NavigationState: NSObject, WKNavigationDelegate {
    var currentURL: URL?
    var webView: WKWebView
    var isLoading: Bool = true
    
    override init() {
        let _webView = WKWebView()
        _webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        self.webView = _webView
        super.init()
        _webView.navigationDelegate = self
//        _webView.uiDelegate = self
    }
    
    func loadRequest(_ urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
    
    func invokeJS() {
        webView.evaluateJavaScript("refreshToken();")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        return WKNavigationActionPolicy.allow
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.isLoading = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.currentURL = webView.url
        self.isLoading = false
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // 強迫認證憑證
        let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, cred)
    }
}
