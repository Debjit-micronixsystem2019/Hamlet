//
//  NewsletterViewController.swift
//  Hamlet
//
//  Created by admin on 11/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import WebKit

class NewsletterViewController: UIViewController {
        
    @IBOutlet weak var webview: WKWebView!
    
    var webload = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if webload == "About"{
            self.title = "About Us"
            webview.load(URLRequest(url: RequestURL.AboutUs.url!))
        }else if webload == "ContactUs"{
            self.title = "Contact Us"
            webview.load(URLRequest(url: RequestURL.ContactUs.url!))
        }else if webload == "Privacy"{
            self.title = "Privacy Policy"
            webview.load(URLRequest(url: RequestURL.Privacy.url!))
        }
    }
}
