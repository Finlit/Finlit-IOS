//
//  ForgetPasswordVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 08/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController, UITextFieldDelegate {
    
    var validator:Validators!
    @IBOutlet weak var mEmailTextField: UITextField!
    @IBOutlet weak var mView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.validator = Validators()
self.mEmailTextField.delegate = self
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mGetVeri(_ sender: UIButton) {
        
        guard validator.validatorEmail(TF1: self.mEmailTextField) == false
            else
        {
            let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVCID") as! ForgetPasswordVC
            self.navigationController?.pushViewController(destinationvc, animated: true)
            return
        }
        
//        if mEmailTextField.text?.count == 0
//        {
//                let alert = UIAlertController(title: "Incomplete Email", message: "Please enter the complete Email", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
//                self.present(alert, animated: true)
//                return
//        }
//
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func mBackBtnTapped(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
        
    }
    
    


}
