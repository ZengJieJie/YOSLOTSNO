//
//  EmeraldGamViewController.swift
//  EmeraldSlotsSpin
//
//  Created by adin on 2024/8/31.
//

import UIKit

class EmeraldGamViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var viewGame: UIView!

    var score: Int = 0
    var gameTimer: Timer?
    var itemTimer: Timer?
    let goodItems = ["🛰️", "🔋", "⭐"]
    let badItems = ["☄️", "🪨"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }

    func setupGame() {
        score = 0
        updateScoreLabel()
        startGameTimers()
    }

    func startGameTimers() {
        itemTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(dropItem), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(increaseGameSpeed), userInfo: nil, repeats: true)
    }

    @objc func dropItem() {
        let isGoodItem = Bool.random()
        let itemName = isGoodItem ? goodItems.randomElement()! : badItems.randomElement()!

        let itemButton = UIButton()
        itemButton.setImage(UIImage(named: itemName), for: .normal)
        itemButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        let randomX = CGFloat.random(in: 0...(viewGame.frame.width - 100))
        let randomY = CGFloat.random(in: 0...(viewGame.frame.height - 100))
        itemButton.frame = CGRect(x: randomX, y: randomY, width: 100, height: 100)
        
        itemButton.tag = isGoodItem ? 100 : 101
        
        itemButton.addTarget(self, action: #selector(handleItemTap(_:)), for: .touchUpInside)

        viewGame.addSubview(itemButton)

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak itemButton] _ in
            itemButton?.removeFromSuperview()
        }
    }

    @objc func handleItemTap(_ sender: UIButton) {
        if sender.tag == 100 {
            score += 10
        } else {
            score -= 10
        }

        if score <= 0 {
            score = 0
            gameOver()
        }

        updateScoreLabel()
        
        sender.removeFromSuperview()
    }
    
    @objc func increaseGameSpeed() {
        itemTimer?.invalidate()
        let newInterval = max(0.5, itemTimer?.timeInterval ?? 1.5 - 0.2)
        itemTimer = Timer.scheduledTimer(timeInterval: newInterval, target: self, selector: #selector(dropItem), userInfo: nil, repeats: true)
    }

    func updateScoreLabel() {
        scoreLabel.text = "Score: \(score)"
    }

    func gameOver() {
        itemTimer?.invalidate()
        gameTimer?.invalidate()

        let alert = UIAlertController(title: "Game Over", message: "Your score reached zero.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.setupGame()
        }))
        present(alert, animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
