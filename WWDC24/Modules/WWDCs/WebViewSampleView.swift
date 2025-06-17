//
//  WebViewSampleView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 14/06/25.
//

import SwiftUI
import WebKit

struct WebViewSampleView: View {
    private var url: URL? {
        URL(string: "https://developer.apple.com")
    }
    
    var body: some View {
        if #available(iOS 18.4, *) {
            WebView(url: url)
                .webViewBackForwardNavigationGestures(.disabled)
                .webViewLinkPreviews(.enabled)
        } else {
            Text(.webViewNotAvailableOnIOS184)
                .font(.headline)
        }
    }
}

#Preview {
    WebViewSampleView()
}
