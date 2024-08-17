//
//  Slotgame.swift
//  JackpotSlotJubilee
//
//  Created by FJ on 09/08/24.
//

import UIKit

class YoSlotsNoSlotGameVC: UIViewController {
    
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var betAddButton: UIButton!
    @IBOutlet weak var betSubtractButton: UIButton!
    @IBOutlet weak var spinButton: UIButton!
    
    let imageNames = ["A1", "A2", "A3", "A4", "A5", "A6" , "A7"]
    var currentBet: Int = 10
    var points: Int = 100
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            return .landscape
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        updateUI()
    }
    
    private func updateUI() {
        betLabel.text = "Bet: \(currentBet)"
        pointsLabel.text = "Points: \(points)"
    }
    
    @IBAction func betAddButtonTapped(_ sender: UIButton) {
        currentBet += 10
        updateUI()
    }
    
    @IBAction func betSubtractButtonTapped(_ sender: UIButton) {
        if currentBet > 10 {
            currentBet -= 10
            updateUI()
        }
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        guard points >= currentBet else {
            resultLabel.text = "Not enough points!"
            return
        }
        
        points -= currentBet
        let results = spinReels()
        updateUI()
        checkResults(results)
    }
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    private func spinReels() -> [String] {
        let result1 = imageNames.randomElement()!
        let result2 = imageNames.randomElement()!
        let result3 = imageNames.randomElement()!
        
        pickerView1.selectRow(imageNames.firstIndex(of: result1)!, inComponent: 0, animated: true)
        pickerView2.selectRow(imageNames.firstIndex(of: result2)!, inComponent: 0, animated: true)
        pickerView3.selectRow(imageNames.firstIndex(of: result3)!, inComponent: 0, animated: true)
        
        return [result1, result2, result3]
    }
    
    private func checkResults(_ results: [String]) {
        if results[0] == results[1] && results[1] == results[2] {
            points += currentBet * 2
            resultLabel.text = "You won \(currentBet * 2) points!"
        } else {
            resultLabel.text = "Try again!"
        }
    }
}

extension YoSlotsNoSlotGameVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: UIImage(named: imageNames[row]))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: 80) // Adjust height as needed
        return imageView
    }
    
    // Set custom row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 160 // Adjust the height as needed
    }
}
