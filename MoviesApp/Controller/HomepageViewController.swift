//
//  HomepageViewController.swift
//  MoviesApp
//
//  Created by Burak Güzey on 18.11.2022.
//

import Foundation
import UIKit
import WebKit

class HomepageViewController: UIViewController, WKNavigationDelegate {
    
    let webView = WKWebView()
    var homepageString: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = view.bounds
                       webView.navigationDelegate = self

                       let url = URL(string: homepageString!)!
                       let urlRequest = URLRequest(url: url)

                       webView.load(urlRequest)
                       webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
                       view.addSubview(webView)
                
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated  {
                if let url = navigationAction.request.url,
                   let host = url.host, !host.hasPrefix((homepageString)!),
                    UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                    return
                } else {
                    decisionHandler(.allow)
                    return
                }
            } else {
                decisionHandler(.allow)
                return
            }
        }

}
