//
//  TANDC.swift
//  YoSlotsNo
//
//  Created by jin fu on 2024/8/17.
//

import Foundation
import UIKit

class YoSlotsNoTANDCVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
}
