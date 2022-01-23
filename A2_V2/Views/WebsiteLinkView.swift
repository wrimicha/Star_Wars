//
//  WebsiteLink.swift
//  Assignment1
//
//  Created by Michael Wright on 2021-09-23.
//

import SwiftUI
import WebKit

struct WebsiteLinkView: View {
    let urlAddress  = URL(string: "https://www.google.ca")
    
    var body: some View {
         ZStack {
            Image("starwarsbg11")
                 .resizable()
                 .scaledToFill()
                 .edgesIgnoringSafeArea(.all)
                 .opacity(0.80)

                Webview(url: urlAddress!)
                .padding(10)
            }
        .navigationBarTitle("Web View")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteLinkView()
    }
}

struct Webview: UIViewRepresentable {
    let url: URL

    //make the webkit view
    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
        let webview = WKWebView()

        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)

        return webview
    }

    //refresh the webkit view
    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}
