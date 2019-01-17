//
//  SignInVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 08/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SignInVC: UIViewController
{
    
    var validator:Validators!
    @IBOutlet weak var mViewRound: UIView!
    @IBOutlet weak var mEmailTextField: UITextField!
    @IBOutlet weak var mViewRound1: UIView!
    @IBOutlet weak var mPasswordTextField: UITextField!
    @IBOutlet weak var mButtonRound: UIButton!
     private var userApi : UserAPI!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.validator = Validators()
        self.userApi = UserAPI.sharedInstance
        self.navigationController?.navigationBar.isHidden = true
        self.mEmailTextField.delegate = self
        self.mPasswordTextField.delegate = self
      
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mForgotPassword(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVCID") as! ForgetPasswordVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
        return
        
    }
    
    
    
    @IBAction func mFacebookBtnTapped(_ sender: UIButton) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err) in
            if err != nil {
                print("Facebook Login failed: \(err)")
                return
            }
            
            if result?.isCancelled == true {
                print("Cancel was pressed")
                return
            }
            print(result?.token.tokenString)
            SVProgressHUD.dismiss()
            self.showUserDetailsFromFb()
            
        }
    }
    
    
    
    
    func showUserDetailsFromFb() {
        FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields" : "id, name, email, picture.type(large)"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request: \(err)")
                return
            }
            print(result)
            var userDetailsDict = User.init(dictionary: result as! NSDictionary)
            
            
            let FbUserID = userDetailsDict?.id
            let FbEmail = userDetailsDict?.email
            let FbName = userDetailsDict?.name
            let FbGender = userDetailsDict?.gender
            let FbImageUrl = "https://graph.facebook.com/\(FbUserID!)/picture?type=large"
            
            var dToken = "0000"
            
            let userDict = [UserAttributes.email.rawValue:FbEmail!,
                            "facebookId":FbUserID,
                            appConstants.deviceType: "iOS",
                            appConstants.deviceId: dToken] as [String : AnyObject]
            
            self.userSignIn(userDict: userDict as Dictionary<String, AnyObject>)
            return
            
            
            
        }
    }
    
    
    
    @IBAction func mSignUpBtnTapped(_ sender: UIButton) {
        guard validator.validatorEmail(TF1: self.mEmailTextField) == false
        else
        {
          var dToken = ""
//          if  let fcmDeviceToken = Messaging.messaging().fcmToken{
//            dToken = fcmDeviceToken
//            print(dToken)
//          }
          
          let userDict = [UserAttributes.email.rawValue:self.mEmailTextField.text!,
                          UserAttributes.password.rawValue:self.mPasswordTextField.text!,
                          appConstants.deviceType: "iOS",
                          appConstants.deviceId: dToken] as [String : AnyObject]
          
          self.userSignIn(userDict: userDict as Dictionary<String, AnyObject>)
          
          return
    
      }
    }
  
  
  func userSignIn(userDict:Dictionary<String, AnyObject>)
    
  {
    SVProgressHUD.show(withStatus: "Please Wait")
    userApi.userSignIn(userDetials: userDict as Dictionary<String, AnyObject> ){ (isSuccess,response, error) -> Void in
      SVProgressHUD.dismiss()
      
      if (isSuccess){
        SVProgressHUD.dismiss()
        Constants.kUserDefaults.set("active", forKey: UserAttributes.status.rawValue)
        Constants.kUserDefaults.set(self.mEmailTextField.text! as String, forKey: appConstants.email)
        Constants.kUserDefaults.set(self.mPasswordTextField.text! as String, forKey: appConstants.password)
        
        kAppDelegate.showNotification(text: "Login Successfully")
        self.navigateToHome()
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
  
  
  func navigateToHome() {
    let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCID") as! HomeVC
    self.navigationController?.pushViewController(destinationvc, animated: true)
    
  }


    @IBAction func mSignUp(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mBackBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    

}

extension SignInVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        switch textField {
        case self.mEmailTextField:
            textField.resignFirstResponder()
            
            return true
        case self.mPasswordTextField:
            textField.resignFirstResponder()
            
            return true
            
        default:
            print("abc")
        }
        
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
        return true
}

}
