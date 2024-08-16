//
//  SecondGame.swift
//  JackpotSlotJubilee
//
//  Created by FJ on 09/08/24.
//

import UIKit

class SecondGame: UIViewController {

    @IBOutlet weak var slotGridView: UIView!
    @IBOutlet weak var powerBarLabel: UILabel!
    @IBOutlet weak var elementalPowerButton: UIButton!
    @IBOutlet weak var spinButton: UIButton!

    let elements = ["Fire", "Water", "Earth", "Air", "Lightning"]
    let gridSize = 5
    var slots: [[UIButton]] = []
    var powerBarValue: Int = 0 {
        didSet {
            powerBarLabel.text = "Power: \(powerBarValue)"
            elementalPowerButton.isEnabled = powerBarValue >= 100
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            return .landscape
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlotGrid()
        powerBarValue = 0
        elementalPowerButton.isEnabled = false
    }

    private func setupSlotGrid() {
        let buttonSize: CGFloat = 60
        for row in 0..<gridSize {
            var rowButtons: [UIButton] = []
            for col in 0..<gridSize {
                let button = UIButton(frame: CGRect(x: CGFloat(col) * buttonSize, y: CGFloat(row) * buttonSize, width: buttonSize, height: buttonSize))
                
                if let backgroundImage = UIImage(named: "bbjc") {
                    button.setBackgroundImage(backgroundImage, for: .normal)
                      }
               
                
                button.tag = row * gridSize + col
                button.addTarget(self, action: #selector(slotButtonTapped(_:)), for: .touchUpInside)
                slotGridView.addSubview(button)
                rowButtons.append(button)
            }
            slots.append(rowButtons)
        }
    }
    
    @objc private func slotButtonTapped(_ sender: UIButton) {
        // Slot button tapped (not used in this basic implementation)
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        spinSlots()
    }
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.dismiss(animated: true, completion: nil)
       // self.navigationController?.popViewController(animated: true)
    }
    
    private func spinSlots() {
        let randomElements = (0..<gridSize*gridSize).map { _ in elements.randomElement()! }
        for (index, button) in slots.flatMap({ $0 }).enumerated() {
            let element = randomElements[index]
            button.setTitle(element, for: .normal)
            button.backgroundColor = colorForElement(element)
            button.setBackgroundImage(nil, for: .normal)
        }
        updatePowerBar()
    }
    
    private func colorForElement(_ element: String) -> UIColor {
        switch element {
        case "Fire": return .red
        case "Water": return .blue
        case "Earth": return .brown
        case "Air": return .lightGray
        case "Lightning": return .yellow
        default: return .gray
        }
    }
    
    private func updatePowerBar() {
        powerBarValue += 10
        if powerBarValue >= 100 {
            // Optionally play an animation or sound effect
        }
    }
    
    @IBAction func elementalPowerButtonTapped(_ sender: UIButton) {
        // Activate elemental power
        let alert = UIAlertController(title: "Elemental Power", message: "Elemental power activated!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
//    @IBAction func miniGameButtonTapped(_ sender: UIButton) {
//        // Trigger mini-game
//        let alert = UIAlertController(title: "Mini-Game", message: "Mini-game activated!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true, completion: nil)
//    }
}
