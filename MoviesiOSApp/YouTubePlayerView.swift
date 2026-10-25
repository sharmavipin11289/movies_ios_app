//
//  YouTubePlayerView.swift
//  MoviesiOSApp
//
//  Created by Vipin Sharma on 25/10/26.
//

import SwiftUI
import WebKit

/// Plays the YouTube embed inside a WKWebView.
struct YouTubePlayerView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        // YouTube refuses embeds that have no https origin (error 153).
        webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube-nocookie.com"))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
