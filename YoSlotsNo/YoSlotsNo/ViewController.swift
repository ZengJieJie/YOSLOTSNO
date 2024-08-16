//
//  ViewController.swift
//  JackpotSlotJubilee
//
//  Created by FJ on 09/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    
    private var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            return .landscape
        }
    
    private let wheelView = WheelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
           
        // Set up the wheel view
        setupWheelView()
        
        // Initialize score
        score = 0
    }
    
   

    
    private func setupWheelView() {
        wheelView.frame = CGRect(x: (view.bounds.width - 200) / 2, y: (view.bounds.height - 200) / 2, width: 200, height: 200)
        wheelView.backgroundColor = .clear
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

class WheelView: UIView {
    
    private let segmentCount = 5
    private let colors: [UIColor] = [.red, .blue, .green, .yellow, .purple]
    private let rewards: [String] = ["Points 0", "Points 50", "Points 0", "Points 20", "Points 10"]
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let anglePerSegment = CGFloat(2 * Double.pi) / CGFloat(segmentCount)
        
        for i in 0..<segmentCount {
            let startAngle = anglePerSegment * CGFloat(i)
            let endAngle = startAngle + anglePerSegment
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLine(to: center)
            colors[i].setFill()
            path.fill()
        }
        
        // Draw segment labels
        for i in 0..<segmentCount {
            let angle = anglePerSegment * CGFloat(i) + anglePerSegment / 2
            let x = center.x + radius / 2 * cos(angle)
            let y = center.y + radius / 2 * sin(angle)
            let label = UILabel(frame: CGRect(x: x - 30, y: y - 10, width: 60, height: 20))
            label.text = rewards[i]
            label.textAlignment = .left
            label.textColor = .white
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 14)
            label.transform = CGAffineTransform(rotationAngle: angle)
            addSubview(label)
        }
    }
    
    func spinWheel(completion: @escaping (String) -> Void) {
        let anglePerSegment = CGFloat(2 * Double.pi) / CGFloat(segmentCount)
        let randomIndex = Int(arc4random_uniform(UInt32(segmentCount)))
        let spinAngle = anglePerSegment * CGFloat(randomIndex) + anglePerSegment / 2
        
        UIView.animate(withDuration: 2.0, animations: {
            self.transform = CGAffineTransform(rotationAngle: spinAngle)
        }) { _ in
            completion(self.rewards[randomIndex])
        }
    }
}
