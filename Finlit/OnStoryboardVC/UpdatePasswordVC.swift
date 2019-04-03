//
//  UpdatePasswordVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 30/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class UpdatePasswordVC: UIViewController {

    @IBOutlet weak var mReEnterPassword: UITextField!
    @IBOutlet weak var mNewPassword: UITextField!
    @IBOutlet weak var mOldPassword: UITextField!
    
    var user:User?
    private var userApi : UserAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   userApi = UserAPI.sharedInstance
        self.mReEnterPassword.delegate = self
        self.mNewPassword.delegate = self
        self.mOldPassword.delegate = self
        
       
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    
    @IBAction func mBackBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func mUpdatePasswordBtnAct(_ sender: Any) {
        if mOldPassword.text == "" {
            kAppDelegate.showNotification(text: "Please make sure to enter some input.")

        }else if  mNewPassword.text == ""{
            kAppDelegate.showNotification(text: "Please make sure to enter some input.")

        } else if  mReEnterPassword.text == ""{
            kAppDelegate.showNotification(text: "Please make sure to enter some input.")
        }else if mNewPassword.text != mReEnterPassword.text{
            kAppDelegate.showNotification(text: "Make sure you re-enter same password.")
        }else{
        self.user = User.init(dictionary: NSDictionary())
        self.user?.userId = Constants.kUserDefaults.value(forKey: appConstants.userId) as? String
        self.user?.newPassword = mNewPassword.text!
        self.user?.password = mOldPassword.text!
        
            userUpdateProfile(userDict: user!)
            
        }
        
    }
    // MARK: User SignUp Function
    func userUpdateProfile(userDict:User)
        
    {
        SVProgressHUD.show(withStatus: "Please Wait")
        UserAPI().userUpdateProfile(userDetials: userDict){ (isSuccess,response, error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                SVProgressHUD.dismiss()
                kAppDelegate.showNotification(text: "Profile Updated Successfully")
                Constants.kUserDefaults.set("active", forKey: UserAttributes.status.rawValue)
                //self.performSegue(withIdentifier: "segueToHome", sender: self)
                _ = Constants.kUserDefaults.value(forKey: appConstants.userId) as? String
              
                                let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCID") as! HomeVC
                                self.navigationController?.pushViewController(destinationvc, animated: true)
                return
                
                
                
            }else{
                SVProgressHUD.dismiss()
                if error != nil{
                    kAppDelegate.showNotification(text: error!)
                }else{
                    kAppDelegate.showNotification(text: "Something went wrong!")
                }
            }
            
        }
        
        
    }

}



extension UpdatePasswordVC :UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
}
}
