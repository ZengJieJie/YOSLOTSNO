//
//  AnzjViewController.swift
//  AnzjSagaSlotSpins
//
//  Created by adin on 2024/8/23.
//

import UIKit
import SpriteKit

class AnzjViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

class GameScene: SKScene {

    // Player's position
    var player: SKSpriteNode!

    // Nodes that will be revealed by the echo
    var hiddenNodes: [SKSpriteNode] = []

    // Score label
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    // Nodes found counter
    var nodesFound: Int = 0

    override func didMove(to view: SKView) {
        backgroundColor = .clear // Set scene background to clear

        // Create the player
        player = SKSpriteNode(color: .white, size: CGSize(width: 40, height: 40))
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player)

        // Create the score label
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.height - 50)
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)

        // Create hidden nodes
        createHiddenNodes()
    }

    func createHiddenNodes() {
        // Remove any existing nodes
        hiddenNodes.forEach { $0.removeFromParent() }
        hiddenNodes.removeAll()

        // Create 5 hidden nodes
        for _ in 0..<5 {
            let node = SKSpriteNode(color: .blue, size: CGSize(width: 60, height: 60))
            node.position = CGPoint(x: CGFloat.random(in: 100...frame.width - 100),
                                    y: CGFloat.random(in: 100...frame.height - 100))
            node.alpha = 0 // Initially hidden
            node.name = "hiddenNode" // Assign a name to identify these nodes
            hiddenNodes.append(node)
            addChild(node)
        }

        // Reset nodes found counter
        nodesFound = 0
    }

    // Emit echo on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        emitEcho(from: location)
    }

    func emitEcho(from position: CGPoint) {
        let echo = SKShapeNode(circleOfRadius: 10)
        echo.position = position
        echo.strokeColor = .white
        echo.lineWidth = 2
        addChild(echo)

        // Animation to make the echo grow and fade out
        let scaleAction = SKAction.scale(to: 10.0, duration: 1.0)
        let fadeAction = SKAction.fadeOut(withDuration: 1.0)
        let removeAction = SKAction.removeFromParent()
        let groupAction = SKAction.group([scaleAction, fadeAction])
        let sequenceAction = SKAction.sequence([groupAction, removeAction])

        echo.run(sequenceAction)

        // Reveal hidden nodes within the echo's radius
        for node in hiddenNodes {
            let distance = hypot(node.position.x - position.x, node.position.y - position.y)
            if distance < echo.frame.width / 2 && node.alpha == 0 {
                // Node revealed and marked as revealed
                let revealAction = SKAction.fadeAlpha(to: 1.0, duration: 0.2)
                node.run(revealAction)

                // Disable further interactions with this node
                node.alpha = 1.0
                node.name = "revealedNode" // Mark as revealed

                // Add score for finding a node
                score += 10
                nodesFound += 1

                // If all nodes are found, start a new game
                if nodesFound == hiddenNodes.count {
                    run(SKAction.sequence([
                        SKAction.wait(forDuration: 2.0), // Wait 2 seconds
                        SKAction.run { self.startNewGame() }
                    ]))
                }
            }
        }
    }

    func startNewGame() {
        score = 0
        createHiddenNodes()
    }
}


class GameViewController: UIViewController {

    @IBOutlet weak var vwgame: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let skView = self.vwgame as? SKView {
            skView.isOpaque = false // Allow transparency in SKView
            skView.backgroundColor = .clear // Set SKView background to clear
            
            let scene = GameScene(size: vwgame.bounds.size)
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .clear // Set GameScene background to clear
            
            skView.presentScene(scene)
            
            skView.ignoresSiblingOrder = true
            skView.showsFPS = false
            skView.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
