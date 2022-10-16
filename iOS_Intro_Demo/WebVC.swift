//
//  WebVC.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import UIKit
import WebKit

class WebVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
        webView.load(URLRequest(url: Bundle.main.url(forResource: "copyright", withExtension: "html")!))
    }
}
