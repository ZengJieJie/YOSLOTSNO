//
//  EmeraldSolViewController.swift
//  EmeraldSlotsSpin
//
//  Created by adin on 2024/8/31.
//

import UIKit

class EmeraldSolViewController: UIViewController {

   
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var slot1ImageView: UIImageView!
    @IBOutlet weak var slot2ImageView: UIImageView!
    @IBOutlet weak var slot3ImageView: UIImageView!
    @IBOutlet weak var spinButton: UIButton!
    
    @IBOutlet weak var spaceshipImageView: UIImageView!
    @IBOutlet weak var asteroidImageView: UIImageView!
    
    @IBOutlet weak var betSegmentedControl: UISegmentedControl!
    
    var currentPoints: Int64 = 1000
    var slotImages = ["🔋", "🛠️", "🛰️", "☄️", "🌌", "🪨"]
    var spaceshipBoostImages = ["🔋", "🛠️", "🛰️"]
    var asteroidBoostImages = ["☄️", "🌌", "🪨"]
    
    var spaceshipPosition: CGFloat = 0
    var asteroidPosition: CGFloat = 0
    let movePoints: Int = 10
    let finishLine: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        betSegmentedControl.isUserInteractionEnabled = false
        let slot1 = slotImages.randomElement()!
        let slot2 = slotImages.randomElement()!
        let slot3 = slotImages.randomElement()!
        
        slot1ImageView.image = UIImage(named: slot1)
        slot2ImageView.image = UIImage(named: slot2)
        slot3ImageView.image = UIImage(named: slot3)
        
        currentPoints -= 3
        
        let slots = [slot1, slot2, slot3]
        let spaceshipBoostCount = slots.filter { spaceshipBoostImages.contains($0) }.count
        let asteroidBoostCount = slots.filter { asteroidBoostImages.contains($0) }.count
        
        if spaceshipBoostCount >= 2 {
            moveSpaceship()
        } else if asteroidBoostCount >= 2 {
            moveAsteroid()
        }
        
        updatePointsLabel()
        checkForWinner()
    }
    
    func updatePointsLabel() {
        pointsLabel.text = "Points: \(currentPoints)"
    }
    
    func moveSpaceship() {
        spaceshipPosition += CGFloat(movePoints)
        if spaceshipPosition >= finishLine {
            spaceshipPosition = finishLine
        }
        spaceshipImageView.frame.origin.x = spaceshipPosition
    }
    
    func moveAsteroid() {
        asteroidPosition += CGFloat(movePoints)
        if asteroidPosition >= finishLine {
            asteroidPosition = finishLine
        }
        asteroidImageView.frame.origin.x = asteroidPosition
    }
    
    func checkForWinner() {
        let betIndex = betSegmentedControl.selectedSegmentIndex
        
        if betIndex == UISegmentedControl.noSegment {
            showAlert(with: "Please select a bet before spinning.")
            return
        }
        
        let userBet = betIndex == 0 ? "Spaceship" : "Asteroid"
        
        if spaceshipPosition >= finishLine {
            if userBet == "Spaceship" {
                currentPoints += 1000
                showAlert(with: "Spaceship Wins! You won 1000 points.")
            } else {
                currentPoints -= 10
                showAlert(with: "Spaceship Wins! You lost 10 points.")
            }
            resetPositions()
        } else if asteroidPosition >= finishLine {
            if userBet == "Asteroid" {
                currentPoints += 1000
                showAlert(with: "Asteroid Wins! You won 1000 points.")
            } else {
                currentPoints -= 10
                showAlert(with: "Asteroid Wins! You lost 10 points.")
            }
            resetPositions()
        }
        
        updatePointsLabel()
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Race Over", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.resetPositions()
            self.betSegmentedControl.isUserInteractionEnabled = true
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func resetPositions() {
        spaceshipPosition = 0
        asteroidPosition = 0
        spaceshipImageView.frame.origin.x = spaceshipPosition
        asteroidImageView.frame.origin.x = asteroidPosition
    }
    
    func resetGame() {
        currentPoints = 1000
        updatePointsLabel()
        resetPositions()
    }
}
