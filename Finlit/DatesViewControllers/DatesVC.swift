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
    var queryForFilterType  = "isInterest"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datesAPI = DatesAPI.sharedInstance
         self.userMdlArry = [User]()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
      
        mDatesTblView.rowHeight = UITableViewAutomaticDimension
        mDatesTblView.estimatedRowHeight = 380
        
        self.ResetBtnProperties()
      self.mAvailableBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
      self.mPinkBotmLbl1.backgroundColor = UIColor.pinkThemeColor()
        
        self.getallDatingUsers(type: queryForFilterType)
    }
    
    
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            if self.categoryType == "Confirmed" {
                self.ResetBtnProperties()
                self.setPendingProperties()
                return
            }
            else if self.categoryType == "Pending" {
                self.ResetBtnProperties()
                self.setAvailableProperties()
                return
            }

        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
            if self.categoryType == "Available" {
                self.ResetBtnProperties()
                self.setPendingProperties()
                return
            }
            
            else if self.categoryType == "Pending" {
                self.ResetBtnProperties()
                self.setConfirmedProperties()
                return
            }
        }
    
    }
    
    func ResetBtnProperties (){
        self.mAvailableBtnOutl.setTitleColor(UIColor.black, for: .normal)
         self.mPendingBtnOutl.setTitleColor(UIColor.black, for: .normal)
         self.mConfirmedBtnOutl.setTitleColor(UIColor.black, for: .normal)
        self.mPinkBotmLbl1.backgroundColor = UIColor.clear
        self.mPinkBotmLbl2.backgroundColor = UIColor.clear
        self.mPinkBotmLbl3.backgroundColor = UIColor.clear
        
    }
    
    func setAvailableProperties () {
        self.mAvailableBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
        self.mPinkBotmLbl1.backgroundColor = UIColor.pinkThemeColor()
        self.categoryType = "Available"
        self.queryForFilterType = "isInterest"
        //mDatesTblView.estimatedRowHeight = 380
        self.getallDatingUsers(type: queryForFilterType)
        
    }
    
    
    func setPendingProperties () {
        self.mPendingBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
        self.mPinkBotmLbl2.backgroundColor = UIColor.pinkThemeColor()
        self.categoryType = "Pending"
        self.queryForFilterType = "isSendr"
        self.getallDatingUsers(type: queryForFilterType)
        
    }
    func setConfirmedProperties () {
        self.mConfirmedBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
        self.mPinkBotmLbl3.backgroundColor = UIColor.pinkThemeColor()
        self.categoryType = "Confirmed"
        self.queryForFilterType = "isConfirmed"
        self.getallDatingUsers(type: queryForFilterType)
        
    }
    
    @IBAction func mAvailableBtnTapped(_ sender: UIButton) {
        self.ResetBtnProperties()
        self.setAvailableProperties()
       
    }
    
    
    @IBAction func mPendingBtnTapped(_ sender: UIButton) {
        self.ResetBtnProperties()
        self.setPendingProperties()
    
    }
    
    
    @IBAction func mConfirmedBtnTapped(_ sender: Any) {
        self.ResetBtnProperties()
        self.setConfirmedProperties()

 
    }
    
    
    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    
    
    @IBAction func mFilterBtnTapped(_ sender: UIBarButtonItem) {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "DatingFiltersVCID") as! DatingFiltersVC
        destinationVC.delegate = self
       self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    //MARK: - Get All Users
    func getallDatingUsers(type: String, minage:String = "",maxAge:String = "") {
        SVProgressHUD.show()
        DatesAPI().getAllAvailableUsers(type: type,minAge:minage,maxAge: maxAge ){ (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    self.userMdlArry = [User]()
                    
                    let userlist = data[APIConstants.items.rawValue] as! NSArray
                    
                    self.userMdlArry = User.modelsFromDictionaryArray(array: userlist)
                    self.mDatesTblView.delegate = self
                    self.mDatesTblView.dataSource = self
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
    
    
    
    //MARK: - Send No Thanks Request
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
    
    //MARK: - Send Confirm Request
    func sendConfirmRequest(IdofUser:String)
        
    {
        SVProgressHUD.show(withStatus: "Please Wait")
        datesAPI.sendConfirmRequest(toUserID: IdofUser){ (isSuccess,data, error) -> Void in
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
    
    
    //MARK: - Send No Thanks Request To Pending User
    func sendNoThanksRequestToPendingUser(IdofUser:String)
        
    {
        SVProgressHUD.show(withStatus: "Please Wait")
        datesAPI.sendNoThanksRequestToPendingUser(toUserID: IdofUser){ (isSuccess,data, error) -> Void in
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
    
    
    
    //MARK: - Send No Thanks Request To Pending User
    func cancelDateRequest(IdofUser:String)
        
    {
        SVProgressHUD.show()
        datesAPI.cancelDateRequest(toUserID: IdofUser){ (isSuccess,data, error) -> Void in
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
        if self.userMdlArry.count == 0 || self.userMdlArry.isEmpty == true  {
            self.mDatesTblView.setEmptyMessage("No Users Yet", tablename: self.mDatesTblView)
        }
            
            
        else {
            self.mDatesTblView.restore()
        }
        
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
            cell.mConfirmInterestBtn.setTitle("Edit", for: .normal)
             cell.mNoThanksBtn.setTitle("Cancel this date", for: .normal)
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
        let name = userr.name != nil ? String(describing: userr.name!) : " "
        cell.mNameAgeLbl.text = name + " " + age
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

   
    
    
    
    
    @objc func IamIntrestedBtnAction(sender:UIButton)  {
        // text to share
        let tag = sender.tag
        let datess = userMdlArry[tag]
        let i = IndexPath(row: tag, section: 0)
         //let cell = mDatesTblView.cellForRow(at: i)  as! DatesTblCell
        
        
        if self.categoryType == "Available" {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "MeetUserVCID") as! MeetUserVC
        let userDets = self.userMdlArry![i.row]
        destinationVC.secondUserDetails = userDets
        self.navigationController?.pushViewController(destinationVC, animated: true)
        }
        
        
        if self.categoryType == "Pending" {
            self.userMdlArry.remove(at: i.row)
            
            if let idd = datess.id {
                self.sendConfirmRequest(IdofUser: idd)
                self.mDatesTblView.reloadData()
            }
            
        }
        
        if self.categoryType == "Confirmed" {
            let userr = self.userMdlArry[i.row]
             let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "MeetUserVCID") as! MeetUserVC
                destinationVC.secondUserDetails = userr
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
        
        
        if self.categoryType == "Pending" {
            self.userMdlArry.remove(at: i.row)
            if let idd = datess.id {
                self.sendNoThanksRequestToPendingUser(IdofUser: idd)}
            self.mDatesTblView.reloadData()
            
        }
        
        
        if self.categoryType == "Confirmed" {
            self.userMdlArry.remove(at: i.row)
            if let idd = datess.id {
                self.cancelDateRequest(IdofUser: idd)}
            self.mDatesTblView.reloadData()
            
        }
        
        
      }
    
    
    
}


extension DatesVC : DatingFiltersVCDelegate {
    func sendAgeRangeValues(minAgeValue: Int, maxAgeValue: Int) {
        let stringMinAge = "&agemin=" + String(minAgeValue)
         let stringMaxAge = "&agemax=" + String(maxAgeValue)
        self.getallDatingUsers(type: queryForFilterType, minage: stringMinAge, maxAge: stringMaxAge)
    }
    
    func sendLocationRangeValues(minLocRangeValue: Int, maxLocRangeValue: Int) {
        
    }
    

    
    
}



    
    

