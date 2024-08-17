//
//  ViewController.swift
//  JackpotSlotJubilee
//
//  Created by FJ on 09/08/24.
//

import UIKit

class YoSlotsNoMainGameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    
    private var score = 0 {
        didSet {
            updateScore()
        }
    }
    
    private func updateScore() {
        scoreLabel.text = "Score: \(score)"
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            return .landscape
        }
    
    private let wheelView = YoSlotsNoWheelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the wheel view
        setupWheelView()
        
        // Initialize score
        score = 0
    }
    
    private func setupWheelView() {
        wheelView.backgroundColor = .clear
        wheelView.frame = CGRect(x: (UIScreen.main.bounds.height - 200) / 2, y: (UIScreen.main.bounds.width - 200) / 2, width: 200, height: 200)
        view.addSubview(wheelView)
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        wheelView.spinWheel { [weak self] reward in
            guard let self = self else { return }
            self.handleWheelReward(reward)
        }
    }
    
    private func handleWheelReward(_ reward: String) {
        var points = 0
        switch reward {
        case "Bonus Spins":
            points = 0
        case "Instant Cash":
            points = 50
        case "Multiplier":
            points = 0
        case "Free Spins":
            points = 20
        case "Jackpot":
            points = 10
        default:
            points = 0
        }
        
        score += points
        
        let alert = UIAlertController(title: "Mystery Wheel Reward", message: "You won: \(reward)\nPoints: \(points)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
}
