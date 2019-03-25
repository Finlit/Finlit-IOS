//
//  UserProfileVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 21/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SDWebImage
class UserProfileVC: UIViewController {
    
    
 
    @IBOutlet weak var mAboutTxtFld: UITextField!
    @IBOutlet weak var mEditBtnOutl: UIButton!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var mProfileImage: UIImageView!
    @IBOutlet weak var mcoverImage: UIImageView!
    @IBOutlet weak var mFinancialInterestTextFiled: UITextField!
    @IBOutlet weak var mGenderTextFiled: UITextField!
    @IBOutlet weak var mAgeTextFiled: UITextField!
    @IBOutlet weak var mLocationTextFiled: UITextField!
    @IBOutlet weak var mprofiletypeImage: UIImageView!
    
    let Gender = ["male","female"]
    let Whatru = ["Credit Card Churning","Stock Trading","Real estate","Retirement planning","Budgut planning","Personal investment","Futures/Forex Trading","Cryptocurrency Trading","Vacation planning"]
    var GenderpickerView = UIPickerView()
    var Whatrupickerview = UIPickerView()
    var locCor: [Double]!
    private var fileUploadAPI:FileUpload!
    var picUrl:String?
    var user:User?
    var opponentId = String()
    var VCcheckInt = Int()
      private var userApi : UserAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userApi = UserAPI.sharedInstance
        mGenderTextFiled.inputView = GenderpickerView
        mFinancialInterestTextFiled.inputView = Whatrupickerview
         self.mcoverImage.alpha = 0.7
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = true
        
        let userId = Constants.kUserDefaults.value(forKey: appConstants.userId)
        print("userId is: \(userId)")
        
        if VCcheckInt == 0{
             getUserDetail(UserID: userId as! String)
            mEditBtnOutl.setTitle("EDIT", for: .normal)
        }else{
            getUserDetail(UserID: opponentId )
            mEditBtnOutl.setTitle("MESSAGE", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    
    
    @IBAction func mSelectedIntrestsBtnTapped(_ sender: UIButton) {
        let resultController = self.storyboard?.instantiateViewController(withIdentifier: "SelectedInterestsPopUpVCID") as? SelectedInterestsPopUpVC
        self.navigationController?.definesPresentationContext = true
        resultController?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        resultController?.modalTransitionStyle = .crossDissolve
        resultController?.InteresrMdlArry = self.user?.interest
        //        resultController?.delegate = self
        self.present(resultController!, animated: true, completion: nil)
    }
    
    
    
    @IBAction func mBackBtn(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func mEditBtn(_ sender: UIButton) {
        if VCcheckInt == 0{
            let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVCID") as! EditProfileVC
            // destinationvc.user = self.user
            self.navigationController?.pushViewController(destinationvc, animated: true)
        }else{
            let otherUserId = self.user?.id
            let otherUsername = self.user?.name
            print(otherUserId!)
            let vc  = storyboard?.instantiateViewController(withIdentifier: "UserChatRoomVCID")as! UserChatRoomVC
            vc.opponentID = otherUserId!
            vc.opponentName = otherUsername!
            if self.user?.imgUrl != nil{
                let otherImgUrl = self.user?.imgUrl
                vc.opponentImgUrl = otherImgUrl!
            }
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }
    @IBAction func mprofileBtnActm(_ sender: Any) {
        
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
