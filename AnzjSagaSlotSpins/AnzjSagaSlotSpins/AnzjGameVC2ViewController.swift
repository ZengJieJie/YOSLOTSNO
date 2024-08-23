//
//  AnzjGameVC2ViewController.swift
//  AnzjSagaSlotSpins
//
//  Created by adin on 2024/8/23.
//

import UIKit
import SpriteKit
class AnzjGameVC2ViewController: UIViewController {

  
    @IBOutlet weak var skView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the SKView background to clear
        skView.backgroundColor = .clear
        skView.isOpaque = false
        let scene = GameS2(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear // Ensure the scene's background is clear
        skView.presentScene(scene)
    }

    func showGameOverAlert() {
        let alert = UIAlertController(title: "Game Over", message: "You scored 0 points!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.restartGame()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func restartGame() {
        if let scene = skView.scene as? GameS2 {
            scene.resetGame()
        }
    }
    
    @IBAction func btnBackTapepd(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}

class GameS2: SKScene {

    var chaser: SKSpriteNode!
    var lightOrb: SKSpriteNode?
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            if score <= 0 {
                score = 0
                gameOver()
            }
        }
    }
    var timer: Timer!

    override func didMove(to view: SKView) {
        backgroundColor = .clear

        // Create the chaser character
        chaser = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        chaser.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(chaser)

        // Create the score label
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.height - 50)
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)

        // Start spawning orbs
        startSpawningOrbs()
    }

    func startSpawningOrbs() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(spawnOrb), userInfo: nil, repeats: true)
    }

    @objc func spawnOrb() {
        // Remove the old orb if it still exists
        lightOrb?.removeFromParent()

        // Create a new light orb
        lightOrb = SKSpriteNode(color: .yellow, size: CGSize(width: 30, height: 30))
        lightOrb!.position = CGPoint(x: CGFloat.random(in: 50...frame.width - 50),
                                     y: CGFloat.random(in: 50...frame.height - 50))
        addChild(lightOrb!)

        // Orb movement
        let moveAction = SKAction.move(to: CGPoint(x: CGFloat.random(in: 50...frame.width - 50),
                                                   y: CGFloat.random(in: 50...frame.height - 50)), duration: 1.0)
        let removeAction = SKAction.run {
            if self.lightOrb != nil {
                self.score -= 10
                self.lightOrb = nil
            }
        }
        lightOrb!.run(SKAction.sequence([moveAction, SKAction.wait(forDuration: 1.0), removeAction, SKAction.removeFromParent()]))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        chaser.position = location

        // Check for collision with the light orb
        if let lightOrb = lightOrb, chaser.frame.intersects(lightOrb.frame) {
            score += 10
            lightOrb.removeFromParent()
            self.lightOrb = nil
        }
    }

    func gameOver() {
        timer.invalidate()
        showGameOverAlert()
    }

    func showGameOverAlert() {
        // Get the view controller that is presenting this scene
        if let viewController = self.view?.window?.rootViewController as? AnzjGameVC2ViewController {
            viewController.showGameOverAlert()
        }
    }

    func resetGame() {
        score = 0
        startSpawningOrbs()
    }

    override func willMove(from view: SKView) {
        timer.invalidate()
    }
}
