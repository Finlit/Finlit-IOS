//
//  OtherUserProfileVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 05/03/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit
import SDWebImage
import Toast_Swift

class OtherUserProfileVC: UIViewController {

    
    @IBOutlet weak var mAboutTxtFld: UITextField!
    @IBOutlet weak var mEditBtnOutl: UIButton!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var mProfileImage: UIImageView!
    @IBOutlet weak var mcoverImage: UIImageView!
    @IBOutlet weak var mFinancialInterestTextFiled: UITextField!
    @IBOutlet weak var mGenderTextFiled: UITextField!
    @IBOutlet weak var mAgeTextFiled: UITextField!
    @IBOutlet weak var mLocationTextFiled: UITextField!
  
    
    
    private var fileUploadAPI:FileUpload!
    var picUrl:String?
    var user:User?
    var opponentId = String()
    private var userApi : UserAPI!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
           self.userApi = UserAPI.sharedInstance
          self.navigationController?.navigationBar.isHidden = true
         getUserDetail(UserID: opponentId )
    }
    
    
    
    @IBAction func mBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func mBlockBtnTapped(_ sender: UIButton) {
        
        self.createActionSheet()
        
    }
    
    
    func createActionSheet() {
        
        let alertController = UIAlertController(title: "", message: "Are you sure you want to block this user?", preferredStyle: .actionSheet)

        let  yesButton = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            print("Yes button tapped")
            let userDict = ["userId":self.opponentId]
            self.blockUser(userDict: userDict as Dictionary<String, AnyObject>)
          
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
      
        alertController.addAction(yesButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func mMessageBtnTapped(_ sender: UIButton) {
        let vc  = storyboard?.instantiateViewController(withIdentifier: "UserChatRoomVCID")as! UserChatRoomVC
        vc.opponentID = opponentId
        vc.opponentName = (user?.name)!
        if user?.imgUrl != nil{
            vc.opponentImgUrl = (user?.imgUrl)!
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    func blockUser(userDict:Dictionary<String, AnyObject>)
        
    {
        userApi.blockUser(userDetails: userDict as Dictionary<String, AnyObject> ){ (isSuccess,response, error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                SVProgressHUD.dismiss()
                self.view.makeToast("User Blocked Successfully")
                  self.navigationController?.popViewController(animated: true)
                
            }
            else{
                SVProgressHUD.dismiss()
                if error != nil{
                    self.view.makeToast(error!)

                }else{
                    self.view.makeToast("Something Went Wrong")
                    
                }
            }
            
        }
        
        
    }
    
    
    

    func getUserDetail(UserID:String){
        userApi.getUserDetails(userId: UserID, pageNo: 1) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    
                    self.user = nil
                    let userlist = data[APIConstants.data.rawValue] as! NSDictionary
                    
                    self.user = User.init(dictionary: userlist)
                    self.putdataTofields()
                }}
            else{
                
                print("Getting Error")
            }
        }
        
    }
        
        
        func putdataTofields(){
            
            if  self.user?.imgUrl != nil {
                print("image url is \(self.user?.imgUrl)")
                self.mProfileImage.sd_setImage(with: URL.init(string:(user?.imgUrl!.httpsExtend)!), placeholderImage: #imageLiteral(resourceName: "cameraicon"))
                self.mcoverImage.sd_setImage(with: URL.init(string:(user?.imgUrl!.httpsExtend)!), placeholderImage: #imageLiteral(resourceName: "squareimage"))
                
            }
            
            mGenderTextFiled.text = user?.gender
            mAboutTxtFld.text = user?.aboutUs
            mFinancialInterestTextFiled.text = user?.question
            mLocationTextFiled.text = user?.address
            
            if user?.ageGroup != nil {
                let age : String! = String(describing: user!.ageGroup!)
                mAgeTextFiled.text = age!
            }
            
            usernameLbl.text = user?.name
        }
        
    }
        
    


