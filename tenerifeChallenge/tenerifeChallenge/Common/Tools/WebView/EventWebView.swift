//
//  EventWebView.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import SwiftUI
import WebKit

struct EventWebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
