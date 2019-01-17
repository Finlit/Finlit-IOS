//
//  VerificationVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 05/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class VerificationVC: UIViewController {
    
     var user : User?
    
    @IBOutlet weak var mTextfield: UITextField!
    @IBOutlet weak var mTextfield1: UITextField!
    @IBOutlet weak var mTextfield2: UITextField!
    @IBOutlet weak var mTextField3: UITextField!
    @IBOutlet weak var mTextfield4: UITextField!
    @IBOutlet weak var mTextfield5: UITextField!
    @IBOutlet weak var mSubmit: UIButton!
    
     private var userApi : UserAPI!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.mTextfield.delegate = self
        self.mTextfield1.delegate = self
        self.mTextfield2.delegate = self
        self.mTextField3.delegate = self
        self.mTextfield4.delegate = self
        self.mTextfield5.delegate = self
        
        
          self.userApi = UserAPI.sharedInstance
        
self.navigationController?.navigationBar.isHidden = false
        self.boder()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func mSubmitTappedBtn(_ sender: UIButton)
    {
    
        if mTextfield.text?.count == 0 && mTextfield1.text?.count == 0 && mTextfield2.text?.count == 0 && mTextField3.text?.count == 0 && mTextfield4.text?.count == 0 && mTextfield5.text?.count == 0

            {
                let alert = UIAlertController(title: "Incomplete OTP", message: "Please enter the complete OTP", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
        
        else {
        
        let otp = self.mTextfield.text! + self.mTextfield1.text! + self.mTextfield2.text! + self.mTextField3.text!  + self.mTextfield4.text!  + self.mTextfield5.text!
        self.userVerify(userPin: otp)
               return
        }
        
     
     

    }

    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func boder()
    {
        self.mTextfield.layer.cornerRadius = CGFloat(10)
        self.mTextfield.layer.borderWidth = 1
        self.mTextfield.layer.borderColor = UIColor.lightGray.cgColor
        self.mTextfield.clipsToBounds = true
        self.mTextfield1.layer.cornerRadius = CGFloat(10)
        self.mTextfield1.layer.borderWidth = 1
        self.mTextfield1.layer.borderColor = UIColor.lightGray.cgColor
        self.mTextfield1.clipsToBounds = true
        self.mTextfield2.layer.cornerRadius = CGFloat(10)
        self.mTextfield2.layer.borderWidth = 1
        self.mTextfield2.layer.borderColor = UIColor.lightGray.cgColor
        self.mTextfield2.clipsToBounds = true
        self.mTextField3.layer.cornerRadius = CGFloat(10)
        self.mTextField3.layer.borderWidth = 1
        self.mTextField3.layer.borderColor = UIColor.lightGray.cgColor
        self.mTextField3.clipsToBounds = true
        self.mTextfield4.layer.cornerRadius = CGFloat(10)
        self.mTextfield4.layer.borderWidth = 1
        self.mTextfield4.layer.borderColor = UIColor.lightGray.cgColor
        self.mTextfield4.clipsToBounds = true
        self.mTextfield5.layer.cornerRadius = CGFloat(10)
        self.mTextfield5.layer.borderWidth = 1
        self.mTextfield5.layer.borderColor = UIColor.lightGray.cgColor
        self.mSubmit.layer.cornerRadius = CGFloat(10)
        self.mSubmit.clipsToBounds = true
    }
    
    
    // MARK: User Verify Function
    func userVerify(userPin:String){
        SVProgressHUD.show(withStatus: "Please Wait")
        
        let userDict = ["userId":Constants.kUserDefaults.string(forKey: appConstants.userId),
                        "activationCode":userPin]
        userApi.userValidatePin(userDetials: userDict as! Dictionary<String, String>){ (isSuccess,user,error) -> Void in
            SVProgressHUD.dismiss()
            
            
            if (isSuccess){
                SVProgressHUD.dismiss()
                kAppDelegate.showNotification(text: "Verified Successfully")
                
                self.navigateToCreateProfileVC()
                
                //            if self.isForgetPassword == true{
                //                self.navigateToSecuritySetup()
                //            }else{
                //                self.navigateToAccountVC(user: user)
                //            }
                
            }
                
            else{
                SVProgressHUD.dismiss()
                if error != nil{
                    kAppDelegate.showNotification(text: error!)
                }else{
                    kAppDelegate.showNotification(text: "Something went wrong!")
                }
            }
            
        }
        
    }
    
    func navigateToCreateProfileVC() {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProfileVCID") as! CreateProfileVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    
    
    
}


extension VerificationVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //On inputing value to textfield
        if ((textField.text?.count)! < 1  && string.count > 0){
           mTextfield.becomeFirstResponder()
            if(textField == mTextfield){
                mTextfield1.becomeFirstResponder()
            }
            if(textField == mTextfield1){
                mTextfield2.becomeFirstResponder()
            }
            if(textField == mTextfield2){
                mTextField3.becomeFirstResponder()
            }
            
            if(textField == mTextField3){
                mTextfield4.becomeFirstResponder()
            }
            
            if(textField == mTextfield4){
                mTextfield5.becomeFirstResponder()
            }
            
            
            if (textField == mTextfield5){
                self.view.endEditing(true)
                
                
            }
            
            textField.text = string
            
            return false
            
            
        }else if ((textField.text?.count)! >= 1  && string.count == 0){
            // on deleting value from Textfield
            if(textField == mTextfield1){
                mTextfield.becomeFirstResponder()
            }
            if(textField == mTextfield2){
                mTextfield1.becomeFirstResponder()
            }
            if(textField == mTextField3) {
                mTextfield2.becomeFirstResponder()
            }
            
            if(textField == mTextfield4) {
                mTextField3.becomeFirstResponder()
            }
            
            if(textField == mTextfield5) {
                mTextfield4.becomeFirstResponder()
            }
            
            textField.text = ""
            return false
        }else if ((textField.text?.count)! >= 1  ){
            textField.text = string
            return false
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
}
