//
//  TermsAndConditionsVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 28/03/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UIViewController {

    var typeOfData : String = ""
    
    @IBOutlet weak var mTxtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        if self.typeOfData == "Terms" {
//            self.navigationController?.navigationItem.title = "Terms and Conditions" }
//
//        else if self.typeOfData == "Privacy" {
//            self.navigationController?.navigationItem.title = "Privacy"
//
//        }
//
//        else {
//             self.navigationController?.navigationItem.title = "Support"
//
//
//        }

   
    }
    
    
    
    
    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    


}
