//
//  DatesVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 11/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class DatesVC: UIViewController {

    @IBOutlet weak var mPendingBtnOutl: UIButton!
    @IBOutlet weak var mConfirmedBtnOutl: UIButton!
    @IBOutlet weak var mAvailableBtnOutl: UIButton!
    @IBOutlet weak var mPinkBotmLbl1: UILabel!
    @IBOutlet weak var mPinkBotmLbl2: UILabel!
    @IBOutlet weak var mPinkBotmLbl3: UILabel!
    @IBOutlet weak var mTopCategView: UIView!
    @IBOutlet weak var mDatesTblView: UITableView!
    var categoryType : String = "Available"
    let vcHelper = VCHelper()
    var cellHeight : CGFloat =  380
    var userMdlArry :  [User]!
    var datesAPI : DatesAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datesAPI = DatesAPI.sharedInstance
         self.userMdlArry = [User]()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
      
        mDatesTblView.rowHeight = UITableViewAutomaticDimension
        mDatesTblView.estimatedRowHeight = 380
        mDatesTblView.delegate = self
        mDatesTblView.dataSource = self
        self.ResetBtnProperties()
      self.mAvailableBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
      self.mPinkBotmLbl1.backgroundColor = UIColor.pinkThemeColor()
        
        self.getallDatingUsers(type: "isInterest")
    }
    
    func ResetBtnProperties (){
        self.mAvailableBtnOutl.setTitleColor(UIColor.black, for: .normal)
         self.mPendingBtnOutl.setTitleColor(UIColor.black, for: .normal)
         self.mConfirmedBtnOutl.setTitleColor(UIColor.black, for: .normal)
        self.mPinkBotmLbl1.backgroundColor = UIColor.clear
        self.mPinkBotmLbl2.backgroundColor = UIColor.clear
        self.mPinkBotmLbl3.backgroundColor = UIColor.clear
        
    }
    
    
    @IBAction func mAvailableBtnTapped(_ sender: UIButton) {
        self.ResetBtnProperties()
        self.mAvailableBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
        self.mPinkBotmLbl1.backgroundColor = UIColor.pinkThemeColor()
        self.categoryType = "Available"
        mDatesTblView.estimatedRowHeight = 380
        self.getallDatingUsers(type: "isInterest")
    }
    
    
    @IBAction func mPendingBtnTapped(_ sender: UIButton) {
        self.ResetBtnProperties()
        self.mPendingBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
        self.mPinkBotmLbl2.backgroundColor = UIColor.pinkThemeColor()
        self.categoryType = "Pending"
         self.getallDatingUsers(type: "isSendr")
    }
    
    
    @IBAction func mConfirmedBtnTapped(_ sender: Any) {
        self.ResetBtnProperties()
        self.mConfirmedBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
        self.mPinkBotmLbl3.backgroundColor = UIColor.pinkThemeColor()
        self.categoryType = "Confirmed"
         self.getallDatingUsers(type: "isConfirmed")
 
    }
    
    
    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    
    func getallDatingUsers(type: String) {
        SVProgressHUD.show()
        DatesAPI().getAllAvailableUsers(type: type){ (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    self.userMdlArry = [User]()
                    
                    let userlist = data[APIConstants.items.rawValue] as! NSArray
                    
                    self.userMdlArry = User.modelsFromDictionaryArray(array: userlist)
                    
                    self.mDatesTblView.reloadData()
                    SVProgressHUD.dismiss()
                }}
            else{
                SVProgressHUD.dismiss()
                print("Getting Error")
            }
            SVProgressHUD.dismiss()
        }
    }
    
    
    
    
    func sendNoThanksRequest(IdofUser:String,userDict:User)
        
    {
        SVProgressHUD.show(withStatus: "Please Wait")
        datesAPI.sendNoThanksRequest(toUserID: IdofUser, dateDetials: userDict){ (isSuccess,data, error) -> Void in
            SVProgressHUD.dismiss()
            if (isSuccess){
                SVProgressHUD.dismiss()
                
            }else{
                SVProgressHUD.dismiss()
                if error != nil{
                    self.view.makeToast(error!)
                    
                }else{
                    self.view.makeToast("Something went wrong!")
                    
                }
            }
            
        }
        
    }
    
    
    
}

extension DatesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userMdlArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatesTblCellID", for: indexPath) as! DatesTblCell
        cell.selectionStyle = .none
        
        let userr = userMdlArry[indexPath.row]
        
        cell.mConfirmInterestBtn.tag = indexPath.row
        cell.mNoThanksBtn.tag = indexPath.row
        
        
        if self.categoryType == "Available" {
            cell.mConfirmInterestBtn.setTitle("I am interested", for: .normal)
            cell.mConfirmInterestBtn.addTarget(self, action: #selector(IamIntrestedBtnAction), for: .touchUpInside)
            cell.mNoThanksBtn.addTarget(self, action: #selector(NoThanksBtnAction), for: .touchUpInside)
           
             let username = userr.name != nil ? String(describing: userr.name!) : "User"
            cell.mWantsToMeetLbl.text = "Hey, \(username.capitalized)" +  " is looking for a date"
            cell.mCalendarIcon.isHidden = true
            cell.mLocationIcon.isHidden = true
            cell.mPlaceLbl.isHidden = true
            cell.mTimeLbl.isHidden = true
            cell.mConfirmBtnTopConst.constant = -40
            cell.mConfirmBtnTopConst.isActive = true
            cell.layoutIfNeeded()
        }
        
        if self.categoryType == "Pending" {
            cell.mConfirmInterestBtn.setTitle("Confirm", for: .normal)
            let username = userr.name != nil ? String(describing: userr.name!) : "User"
            cell.mWantsToMeetLbl.text = "\(username.capitalized)" +  " wants to meet you"
            cell.mCalendarIcon.isHidden = false
            cell.mLocationIcon.isHidden = false
            cell.mPlaceLbl.isHidden = false
            cell.mTimeLbl.isHidden = false
            cell.mPlaceLbl.text = userr.location?.address
            cell.mTimeLbl.text = userr.createdAt?.utcStringToLocalDateTimeForNotification
            cell.mConfirmBtnTopConst.constant = 14
            cell.mConfirmBtnTopConst.isActive = true
            cell.layoutIfNeeded()
        }
        
        
        if self.categoryType == "Confirmed" {
            cell.mConfirmInterestBtn.setTitle("Confirm", for: .normal)
            let username = userr.name != nil ? String(describing: userr.name!) : "User"
            cell.mWantsToMeetLbl.text = "Hey, \(username.capitalized)" +  "is looking for a date"
            cell.mCalendarIcon.isHidden = false
            cell.mLocationIcon.isHidden = false
            cell.mPlaceLbl.isHidden = false
            cell.mTimeLbl.isHidden = false
            cell.mConfirmBtnTopConst.constant = 14
            cell.mConfirmBtnTopConst.isActive = true
            cell.layoutIfNeeded()
        }
        
        
        let age = userr.ageGroup != nil ? String(describing: userr.ageGroup!) : " "
        cell.mNameAgeLbl.text = userr.name! + " " + age
        if userr.imgUrl != nil {
            cell.mProfileImgMain.sd_setImage(with: URL.init(string:((userr.imgUrl!.httpsExtend))), placeholderImage: #imageLiteral(resourceName: "portrait2"))
            cell.mProfileImgSmall.sd_setImage(with: URL.init(string:((userr.imgUrl!.httpsExtend))), placeholderImage: #imageLiteral(resourceName: "portrait2"))
        }
        
         return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.categoryType == "Available" {
            return 360
        }
        
        else {
        
        return 430
        }}
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "MeetUserVCID") as! MeetUserVC
//        let userDets = self.userMdlArry[indexPath.row]
//        destinationVC.secondUserDetails = userDets
//        self.navigationController?.pushViewController(destinationVC, animated: true)
//    }
//
    
    
    
    
    
    @objc func IamIntrestedBtnAction(sender:UIButton)  {
        // text to share
        let tag = sender.tag
        //let datess = userMdlArry[tag]
        let i = IndexPath(row: tag, section: 0)
         //let cell = mDatesTblView.cellForRow(at: i)  as! DatesTblCell
        
        
        if self.categoryType == "Available" {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "MeetUserVCID") as! MeetUserVC
        let userDets = self.userMdlArry![i.row]
        destinationVC.secondUserDetails = userDets
        self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    
    @objc func NoThanksBtnAction(sender:UIButton)  {
        // text to share
        let tag = sender.tag
        let datess = userMdlArry[tag]
        let i = IndexPath(row: tag, section: 0)
        //let cell = mDatesTblView.cellForRow(at: i)  as! DatesTblCell
        
        
        if self.categoryType == "Available" {
            self.userMdlArry.remove(at: i.row)
            var userDict : User?
            userDict = User.init(dictionary: NSDictionary())
            if let idd = datess.id {
                self.sendNoThanksRequest(IdofUser: idd, userDict: userDict!)}
            self.mDatesTblView.reloadData()
            
        }
    }
    
    
    
}



    
    
