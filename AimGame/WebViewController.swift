//
//  WebViewController.swift
//  AimGame
//
//  Created by Igor Belobrov on 05.09.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var link: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        loadWebView()
    }
    
     func loadWebView() {
        guard let link = link else { return }
        let request = URLRequest(url: URL(string: link)!)
        webView.load(request)
    }
    
}

