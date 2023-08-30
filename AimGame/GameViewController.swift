//
//  GameViewController.swift
//  AimGame
//
//  Created by Igor Belobrov on 30.08.2023.
//

import UIKit
import WebKit

class GameViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func playAction(_ sender: Any) {
        
    }
    
}
