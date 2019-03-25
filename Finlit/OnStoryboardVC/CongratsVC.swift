//
//  CongratsVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 09/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class CongratsVC: UIViewController {
    
    
    @IBOutlet weak var mResultImage: UIImageView!
    @IBOutlet weak var mThanks: UIButton!
    var ansResult = String()
    var user:User?
    private var userApi : UserAPI!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mThanks.layer.cornerRadius = CGFloat(10)
        self.mThanks.clipsToBounds = true
        self.userApi = UserAPI.sharedInstance
         checkCorrectAns()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkCorrectAns(){
        if Constants.kUserDefaults.value(forKey: appConstants.isCorrect) != nil{
            print(Constants.kUserDefaults.value(forKey: appConstants.isCorrect))
            print(Constants.kUserDefaults.value(forKey: appConstants.totalQuestionCount))
            let isCorrectAns = Constants.kUserDefaults.value(forKey: appConstants.isCorrect) as! Int
            let totalQuestionCount = Constants.kUserDefaults.value(forKey: appConstants.totalQuestionCount) as! Int
            if totalQuestionCount == 6{
                if isCorrectAns <= 2 {
                    ansResult = "novice"
                    mResultImage.image = #imageLiteral(resourceName: "image-1")
                }else if isCorrectAns >= 3 && isCorrectAns <= 4{
                    ansResult = "proficent"
                    mResultImage.image = #imageLiteral(resourceName: "image-3")
                }else{
                    ansResult = "expert"
                    mResultImage.image = #imageLiteral(resourceName: "expert")
                }
                
            }else{
                if isCorrectAns <= 3 {
                    ansResult = "novice"
                    mResultImage.image = #imageLiteral(resourceName: "image-1")
                }else if isCorrectAns >= 4 && isCorrectAns <= 7{
                    ansResult = "proficent"
                    mResultImage.image = #imageLiteral(resourceName: "image-3")
                }else{
                    ansResult = "expert"
                    mResultImage.image = #imageLiteral(resourceName: "expert")
                }
                
            }
        }
    }

    @IBAction func mThanksBtn(_ sender: UIButton) {
        self.user = User.init(dictionary: NSDictionary())
        self.user?.profileType = ansResult
        self.user?.userId  =  Constants.kUserDefaults.value(forKey: appConstants.userId) as? String
        self.userUpdateProfile(userDict: user!)
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCID") as! HomeVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    
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
                
//                let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileVCID") as! UserProfileVC
//                self.navigationController?.pushViewController(destinationvc, animated: true)
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
