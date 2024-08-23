//
//  AnzjSlotgameViewController.swift
//  AnzjSagaSlotSpins
//
//  Created by adin on 2024/8/23.
//

import UIKit
import AVFoundation
import SwiftyGif

enum AnzjSlotgameSounde {
    case AnzjSlotgameSoundeSpin
    case AnzjSlotgameSoundeWin
    case AnzjSlotgameSoundeLose
}

class AnzjSlotgameViewController: UIViewController {
    
    //MARK: - Declare IBOutlets
    @IBOutlet weak var slotPickerOne: UIPickerView!
    @IBOutlet weak var slotPickerTwo: UIPickerView!
    @IBOutlet weak var slotPickerThree: UIPickerView!
    @IBOutlet weak var btnSpinner: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var spinAudioPlayer: AVAudioPlayer?
    var winAudioPlayer: AVAudioPlayer?
    var loseAudioPlayer: AVAudioPlayer?
    
    //MARK: - Declare Variables
    var itemArray = ["11", "12", "13", "14", "15", "16", "17", "18","19"]
    var extendedItemArray: [String] = []
    var points = 100
    
    let infiniteMultiplier = 100
    
    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            if let soundURL = Bundle.main.url(forResource: "AnzjSpin", withExtension: "mp3") {
                do {
                    self.spinAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    self.spinAudioPlayer?.prepareToPlay()
                } catch {
                    print("player error: \(error.localizedDescription)")
                }
            }
            
            if let soundURL = Bundle.main.url(forResource: "AnzjGameWin", withExtension: "mp3") {
                do {
                    self.winAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    self.winAudioPlayer?.prepareToPlay()
                } catch {
                    print("player error: \(error.localizedDescription)")
                }
            }
            
            
            if let soundURL = Bundle.main.url(forResource: "AnzjGamOver", withExtension: "mp3") {
                do {
                    self.loseAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    self.loseAudioPlayer?.prepareToPlay()
                } catch {
                    print("player error: \(error.localizedDescription)")
                }
            }
        }
        
        do {
            let gif = try UIImage(gifName: "MyImage.gif")
            let imageview = UIImageView(gifImage: gif, loopCount: 3) // Will loop 3 times
            imageview.frame = view.bounds
        } catch {
            print(error)
        }
        
        // Ensure only valid image names are included
        let validItemArray = itemArray.filter { UIImage(named: $0) != nil }
        extendedItemArray = Array(repeating: validItemArray, count: infiniteMultiplier).flatMap { $0 }
        
        slotPickerOne.dataSource = self
        slotPickerOne.delegate = self
        slotPickerTwo.dataSource = self
        slotPickerTwo.delegate = self
        slotPickerThree.dataSource = self
        slotPickerThree.delegate = self
        
        setInitialPickerPositions()
        updatePointsLabel()
    }
    
    //MARK: - Functions
    func setInitialPickerPositions() {
        let middleIndex = (extendedItemArray.count / 2)
        slotPickerOne.selectRow(middleIndex, inComponent: 0, animated: false)
        slotPickerTwo.selectRow(middleIndex, inComponent: 0, animated: false)
        slotPickerThree.selectRow(middleIndex, inComponent: 0, animated: false)
    }
    
    func spinPicker(_ pickerView: UIPickerView) {
        let middleIndex = (extendedItemArray.count / 2)
        let randomOffset = Int.random(in: 0..<itemArray.count)
        let targetIndex = middleIndex + randomOffset
        pickerView.selectRow(targetIndex, inComponent: 0, animated: true)
    }
    
    func calculatePoints() {
        let rowOne = slotPickerOne.selectedRow(inComponent: 0) % itemArray.count
        let rowTwo = slotPickerTwo.selectedRow(inComponent: 0) % itemArray.count
        let rowThree = slotPickerThree.selectedRow(inComponent: 0) % itemArray.count
        
        let selectedItems = [itemArray[rowOne], itemArray[rowTwo], itemArray[rowThree]]
        
        let uniqueItems = Set(selectedItems)
        
        var win: Bool = false
        if uniqueItems.count == 1 {
            switch selectedItems[0] {
            case "7":
                points += 20
                win = true
            case "5":
                points += 15
                win = true
            case "3":
                points += 10
                win = true
            default:
                points += 20
                win = true
            }
            zoomInOutAnimation()
        } else if uniqueItems.count == 2 {
            points += 5
            win = true
        } else {
            points -= 5
        }
        
        if win {
            playGameSoude(.AnzjSlotgameSoundeWin)
        }
        
        updatePointsLabel()
        if points <= 0 {
            restartGame()
            playGameSoude(.AnzjSlotgameSoundeLose)
        }
    }
    
    func zoomInOutAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.slotPickerOne.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.slotPickerTwo.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.slotPickerThree.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.slotPickerOne.transform = .identity
                self.slotPickerTwo.transform = .identity
                self.slotPickerThree.transform = .identity
            })
        }
    }
    
    func updatePointsLabel() {
        pointsLabel.text = "Points: \(points)"
        self.btnSpinner.isEnabled = true
    }
    
    func restartGame() {
        
        let alert = UIAlertController(title: "Game Over", message: "Your points have reached 0. The game will restart.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.points = 100
            self.updatePointsLabel()
            self.setInitialPickerPositions()
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Declare IBAction
    @IBAction func btnSpinSlot(_ sender: Any) {
        self.btnSpinner.isEnabled = false
        spinPicker(slotPickerOne)
        spinPicker(slotPickerTwo)
        spinPicker(slotPickerThree)
        
        playGameSoude(.AnzjSlotgameSoundeSpin)
        // Calculate points after the spinning animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.calculatePoints()
        }
    }
    
    func playGameSoude(_ sounde: AnzjSlotgameSounde) {
        if sounde == .AnzjSlotgameSoundeSpin {
            self.spinAudioPlayer?.play()
            self.winAudioPlayer?.stop()
            self.loseAudioPlayer?.stop()
        } else if sounde == .AnzjSlotgameSoundeWin {
            self.spinAudioPlayer?.stop()
            self.winAudioPlayer?.play()
            self.loseAudioPlayer?.stop()
        } else {
            self.spinAudioPlayer?.stop()
            self.winAudioPlayer?.stop()
            self.loseAudioPlayer?.play()
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UIPickerViewDataSource and UIPickerViewDelegate Methods
extension AnzjSlotgameViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return extendedItemArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        
        // Ensure image name is valid to avoid empty images
        let imageName = extendedItemArray[row]
        if let image = UIImage(named: imageName) {
            imageView.image = image
        } else {
            imageView.image = nil
        }
        
        imageView.frame = CGRect(x: 0, y: 0, width: pickerView.frame.width, height: 50)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
