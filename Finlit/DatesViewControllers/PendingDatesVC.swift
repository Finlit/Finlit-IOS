//
//  PendingDatesVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 01/03/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class PendingDatesVC: UIViewController {

    @IBOutlet weak var mBottomPinkLbl2: UILabel!
    @IBOutlet weak var mBottomPinkLbl1: UILabel!
    @IBOutlet weak var mSentBtnOutl: UIButton!
    @IBOutlet weak var mReceivedBtnOutl: UIButton!
    @IBOutlet weak var mPendingDatesTblView: UITableView!
    
    var userMdlArry : [User]!
    var datesAPI : DatesAPI!
    var categName : String = "Received"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datesAPI = DatesAPI.sharedInstance
        self.userMdlArry = [User]()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        self.getallDatingUsers(type: "isSendr")
        self.navigationController?.navigationBar.isHidden = false
        self.setTopBtn1UI()
       
    }
    
    func setTopBtn1UI () {
        self.mBottomPinkLbl1.backgroundColor = UIColor.pinkThemeColor()
        self.mReceivedBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
        self.mBottomPinkLbl2.backgroundColor = UIColor.clear
        self.mSentBtnOutl.setTitleColor(UIColor.black, for: .normal)
    }
  
    
    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mReceivedTapped(_ sender: UIButton) {
       self.setTopBtn1UI()
        self.categName = "Received"
        self.mPendingDatesTblView.reloadData()
        self.getallDatingUsers(type: "isSendr")
        
    }
    
    
    @IBAction func mSentTapped(_ sender: UIButton) {
        self.mBottomPinkLbl2.backgroundColor = UIColor.pinkThemeColor()
        self.mSentBtnOutl.setTitleColor(UIColor.pinkThemeColor(), for: .normal)
        self.mBottomPinkLbl1.backgroundColor = UIColor.clear
        self.mReceivedBtnOutl.setTitleColor(UIColor.black, for: .normal)
        self.categName = "Sent"
        self.mPendingDatesTblView.reloadData()
         //self.getallDatingUsers(type: "isSendr")
        
    }
    
    
    
    //MARK: - Get All Users
    func getallDatingUsers(type: String) {
        SVProgressHUD.show()
        DatesAPI().getAllAvailableUsers(type: type, minAge: "", maxAge: ""){ (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    self.userMdlArry = [User]()
                    
                    let userlist = data[APIConstants.items.rawValue] as! NSArray
                    
                    self.userMdlArry = User.modelsFromDictionaryArray(array: userlist)
                    self.mPendingDatesTblView.delegate = self
                    self.mPendingDatesTblView.dataSource = self
                    self.mPendingDatesTblView.reloadData()
                    SVProgressHUD.dismiss()
                }}
            else{
                SVProgressHUD.dismiss()
                print("Getting Error")
            }
            SVProgressHUD.dismiss()
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
    


}


extension PendingDatesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userMdlArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingDatesTblCellID", for: indexPath) as! PendingDatesTblCell
        cell.selectionStyle = .none
        
        let userr = userMdlArry[indexPath.row]
        
        cell.mConfirmInterestBtn.tag = indexPath.row
        cell.mNoThanksBtn.tag = indexPath.row
        
        cell.mConfirmInterestBtn.addTarget(self, action: #selector(ConfirmBtnAction), for: .touchUpInside)
        cell.mNoThanksBtn.addTarget(self, action: #selector(NoThanksBtnAction), for: .touchUpInside)
   
        
        if self.categName == "Received" {
            cell.mConfirmInterestBtn.setTitle("Confirm", for: .normal)
            let username = userr.name != nil ? String(describing: userr.name!) : "User"
            cell.mWantsToMeetLbl.text = "\(username.capitalized)" +  " wants to meet you"
            cell.mPlaceLbl.text = userr.location?.address
            cell.mTimeLbl.text = userr.createdAt?.utcStringToLocalDateTimeForNotification

        }
        
        
        if self.categName == "Sent" {
            cell.mConfirmInterestBtn.setTitle("Edit", for: .normal)
            cell.mNoThanksBtn.setTitle("Cancel this date", for: .normal)
            let username = userr.name != nil ? String(describing: userr.name!) : "User"
            cell.mWantsToMeetLbl.text = "Hey, \(username.capitalized)" +  "is looking for a date"

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
    
            return 430
        }
    
    
    @objc func ConfirmBtnAction(sender:UIButton) {
        let tag = sender.tag
        let datess = userMdlArry[tag]
        let i = IndexPath(row: tag, section: 0)
        self.userMdlArry.remove(at: i.row)
        
        if let idd = datess.id {
            self.sendConfirmRequest(IdofUser: idd)
            self.mPendingDatesTblView.reloadData()
        }
        
        
    }
     @objc func NoThanksBtnAction(sender:UIButton) {
        let tag = sender.tag
        let datess = userMdlArry[tag]
        let i = IndexPath(row: tag, section: 0)
        self.userMdlArry.remove(at: i.row)
        if let idd = datess.id {
            self.sendNoThanksRequestToPendingUser(IdofUser: idd)}
        self.mPendingDatesTblView.reloadData()
        
    }
    
    
    
}
