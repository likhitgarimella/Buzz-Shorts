//
//  VideosViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
import WebKit

class VideosViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        let url = URL(string: "https://www.youtube.com/channel/UC6QbQYrqFIiAZeOxKtgbf8Q")
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    
}   // #34
