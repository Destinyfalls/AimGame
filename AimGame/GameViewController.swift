//
//  GameViewController.swift
//  AimGame
//
//  Created by Igor Belobrov on 30.08.2023.
//

import UIKit
import WebKit
import SpriteKit

class GameViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    
    var timer = Timer()
    var timeRemaining = Int()
    var score = Int()
    let aimView = UIView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkFirstLaunch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        playButton.isHidden = false
        timeTextLabel.isHidden = true
        timeLabel.isHidden = true
        scoreLabel.isHidden = true
        score = 0
        aimView.removeFromSuperview()
    }
    
    //MARK: - Functions
    
    private func checkFirstLaunch() {
        if UserDefaults.standard.string(forKey: "firstLogin") == nil {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let rulesVC = storyBoard.instantiateViewController(withIdentifier: "RulesViewController")
            rulesVC.modalPresentationStyle = .formSheet
            self.present(rulesVC, animated: true)
            UserDefaults.standard.set("done", forKey: "firstLogin")
        }
    }
    
    private func setupTimer() {
        timeRemaining = 7
        timeLabel.text = "7 sec"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    private func setupAim() {
        aimView.frame = CGRect(x: Int.random(in: 0...Int(self.view.bounds.maxX-64)), y: Int.random(in: 0...Int(self.view.bounds.maxY-64)), width: 64, height: 64)
        aimView.backgroundColor = .red
        aimView.isUserInteractionEnabled = true
        aimView.layer.cornerRadius = 30
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnAim(_ :)))
        tapgesture.numberOfTapsRequired = 1
        aimView.addGestureRecognizer(tapgesture)
        self.view.addSubview(aimView)
    }
    
    private func getResultAndMoveNext(gameResult: String) {
        activityIndicator.startAnimating()
        NetworkManager.shared.getResult { result in
            DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let webViewVC = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                webViewVC.modalPresentationStyle = .fullScreen
                switch gameResult {
                case "win":
                    webViewVC.link = result?.winner
                case "loose":
                    webViewVC.link = result?.loser
                default:
                    return
                }
                self.activityIndicator.stopAnimating()
                self.navigationController?.pushViewController(webViewVC, animated:true)
            }
        }
    }
    
    @objc func step() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer.invalidate()
            getResultAndMoveNext(gameResult: "loose")
            return
        }
        timeLabel.text = "\(String(timeRemaining)) sec"
    }
    
    @objc func tappedOnAim(_ gesture: UITapGestureRecognizer) {
        gesture.view?.removeFromSuperview()
        score += 1
        scoreLabel.text = "Score: \(score)"
        if score == 10 {
            timer.invalidate()
            getResultAndMoveNext(gameResult: "win")
        } else {
            setupAim()
        }
    }
    
    @IBAction func playAction(_ sender: Any) {
        playButton.isHidden = true
        timeTextLabel.isHidden = false
        timeLabel.isHidden = false
        scoreLabel.isHidden = false
        scoreLabel.text = "Score: \(score)"
        setupAim()
        setupTimer()
    }
    
}
