//
//  SettingVC.swift
//  JackpotSlotJubilee
//
//  Created by FJ on 09/08/24.
//

import UIKit

class YoSlotsNoSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            return .landscape
        }
    @IBAction func btnBackTapped(_ sender : Any){
        self.dismiss(animated: true, completion: nil)

       // self.navigationController?.popViewController(animated: true)
    }
    
}




