//
//  SignUpVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 05/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Toast_Swift

class SignUpVC: UIViewController, UITextFieldDelegate {
     var validator:Validators!
    private var userApi : UserAPI!
     var user:User?
    @IBOutlet weak var mEmailTextField: UITextField!
    var isFbLogin : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.validator = Validators()
        self.userApi = UserAPI.sharedInstance
        self.user = User.init(dictionary: NSDictionary())
        self.navigationController?.navigationBar.isHidden = true
        self.mEmailTextField.delegate = self
      
      let isProfileCompleted = Constants.kUserDefaults.bool(forKey: UserAttributes.isProfileCompleted.rawValue)
      
      if isProfileCompleted == true {
        self.navigateToHome()
        return
      }else{
         Constants.kUserDefaults.set(false, forKey: UserAttributes.isProfileCompleted.rawValue)
      }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return true;
    }

    @IBAction func mFbTappedBtn(_ sender: UIButton) {
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
        
    
    

        
        
        
  
  func navigateToHome() {
    let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCID") as! HomeVC
    self.navigationController?.pushViewController(destinationvc, animated: true)
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
            
            
            
            
            //  destinationvc.NameVar = myDetailsDict?.name
            //            destinationvc.GenderVar = myDetailsDict?.gender
            //            //            destinationvc.DOBVar = myDetailsDict?.birthday
            //            let FBid = myDetailsDict?.id
            //            let FBMailId = myDetailsDict?.email
            //            let FBname = myDetailsDict?.name
            //let FbImage = "https://graph.facebook.com/\(FBid!)/picture?type=large"
            //print(FbImage)
            //destinationvc.PictureURLVar = FbImage
            //            Constants.kUserDefaults.set(FBMailId, forKey: "email")
            //            Constants.kUserDefaults.set(FBname, forKey: "name")
            //            Constants.kUserDefaults.set(FBid, forKey: "userId")
            //            Constants.kUserDefaults.set(FbImage, forKey: "picUrls")
            
            var dToken = "0000"
            //            if  let fcmDeviceToken = Messaging.messaging().fcmToken{
            //                dToken = fcmDeviceToken
            //                print(dToken)
            //            }
            
            self.user?.email = FbEmail //self.mEmailTextField.text
            self.user?.deviceId = Constants.kUserDefaults.value(forKey: appConstants.fcmToken) as? String
            self.user?.deviceType = "iOS"
            self.user?.facebookId = FbUserID
            self.user?.imgUrl = FbImageUrl
            self.user?.name = FbName
            self.user?.gender = FbGender
            self.isFbLogin = true
//
//            let userDict = [appConstants.email : FbEmail as! String,
//                            appConstants.deviceType: "iOS",
//                            appConstants.deviceId: dToken, appConstants.name: FbName, "facebookId":FbUserID, "imgUrl":FbImageUrl] as [String : Any]
            
            //self.isFbLogin = true
            self.userSignUpUser(userDict: self.user!)
            return
            
            
            
        }
        
    }
//
    @IBAction func mSignInTappedBtn(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVCID") as! SignInVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
        return
    }
    
    @IBAction func mSignInBtnTapped(_ sender: UIButton) {
        guard validator.validatorEmail(TF1: self.mEmailTextField,fieldName: "Email") == false
            
            
            else{
                self.user?.email = self.mEmailTextField.text
                self.user?.deviceId = Constants.kUserDefaults.value(forKey: appConstants.fcmToken) as? String
                self.user?.deviceType = "iOS"
                self.user?.deviceId = "0000"
                self.userSignUpUser(userDict: user!)
                return
        }
        }


    
    func userSignUpUser(userDict:User)
        
    {
        SVProgressHUD.show(withStatus: "Please Wait")
        userApi.userSignUp(userDetials: userDict.dictionaryRepresentation() as! Dictionary<String, AnyObject>){ (isSuccess,response, error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                
                SVProgressHUD.dismiss()
                kAppDelegate.showNotification(text: "Request submitted Successfully")
                
                if self.isFbLogin == true {
                    
                    let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProfileVCID") as! CreateProfileVC
                    destinationvc.user = self.user
                    destinationvc.isFbLogin = true
                    self.navigationController?.pushViewController(destinationvc, animated: true)
                    return
                }
                
                let data = response![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
                self.user = User.init(dictionary: data as NSDictionary)
                Constants.kUserDefaults.set(userDict.imgUrl, forKey: appConstants.UserImage)

                Constants.kUserDefaults.set("pending", forKey: UserAttributes.status.rawValue)
                let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVCID") as! VerificationVC
                
                destinationvc.user = self.user
                print(userDict)
                self.navigationController?.pushViewController(destinationvc, animated: true)
            }
            else{
                SVProgressHUD.dismiss()
                if error != nil{
                    self.view.makeToast(error!)
                    kAppDelegate.showNotification(text: error!)
                }else{
                    kAppDelegate.showNotification(text: "Something went wrong!")
                }
            }
        }
    }
        
    }




extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            
            return layer.cornerRadius
            
        }
        
        set {
            
            layer.cornerRadius = newValue
            
            layer.masksToBounds = newValue > 0
            
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            
            return layer.borderWidth
            
        }
        
        set {
            
            layer.borderWidth = newValue
            
        }
        
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        get {
            
            return UIColor(cgColor: layer.borderColor!)
            
        }
        
        set {
            
            layer.borderColor = newValue?.cgColor
            
        }
        
    }
    
}
extension UIButton {
    
    func roundedButton(){
        
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     
                                     byRoundingCorners: [.topLeft , .topRight],
                                     
                                     cornerRadii:CGSize(width:8.0, height:8.0))
        
        let maskLayer1 = CAShapeLayer()
        
        maskLayer1.frame = self.bounds
        
        maskLayer1.path = maskPAth1.cgPath
        
        self.layer.mask = maskLayer1
        
    }
    
}
extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        
        self.leftView = paddingView
        
        self.leftViewMode = .always
        
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        
        self.rightView = paddingView
        
        self.rightViewMode = .always
        
    }
    
    
    
}
