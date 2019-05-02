//
//  NearByVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 15/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage
class NearByVC: UIViewController {

    var refreshControl = UIRefreshControl()
    var NearByDict : NearBySearch?
    private var questionAPI : QuestionAPI!
    private var userApi : UserAPI!
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    var nearByData : [NearBySearch]!
    var filterbyStr = String()
    var ageMax = String()
    var ageMin = String()
    var latStr = String()
    var longStr = String()
    var rangeStr = String()
    var VCcheckInt = Int()
    

    @IBOutlet weak var mNearByTblCell: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        mNearByTblCell.addSubview(refreshControl)
        self.mNearByTblCell.delegate = self
        self.mNearByTblCell.dataSource = self
       
        
    }
    
   
    
    
    @objc func refresh(sender:AnyObject) {
        
        self.navigationController?.navigationBar.isTranslucent = true
        
        if Constants.kUserDefaults.value(forKey:appConstants.selecttype) != nil{
            let type =  Constants.kUserDefaults.value(forKey:appConstants.selecttype)as! String
            getallUsers(type: "?gender=\(type)")
        }else{
            getallUsers(type: "")
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    
        if VCcheckInt == 0{
            self.questionAPI = QuestionAPI.sharedInstance
            userApi = UserAPI.sharedInstance
        self.nearByData = [NearBySearch]()
        currentlocation()
       
            if Constants.kUserDefaults.value(forKey:appConstants.selecttype) != nil{
                let type =  Constants.kUserDefaults.value(forKey:appConstants.selecttype)as! String
                getallUsers(type: "?gender=\(type)")
            }else{
                getallUsers(type: "")
            }
        }
        
        else{
//            if latStr != ""{
//
//            }else if longStr != ""{
//
//            }else if rangeStr == "0.0" {
//              rangeStr = "40000"
//            }else if filterbyStr != ""{
//
//            }else if ageMin == "0.0"{
//                ageMin = "0"
//            }else if ageMax == "0.0"{
//                 ageMax = "100"
//            }else{
//            }
//            print(filterbyStr)
//            let filterbys = filterbyStr.replacingOccurrences(of: "%20", with: " ")
//            print(filterbys)
//            getfilterdata(latitude: "&longitude=\(longStr)", longitude: "latitude=\(latStr)", range: "&range=\("40000")", filterBy: "&filterBy=\(filterbys)", ageMin: "&ageMin=\(ageMin)", ageMax: "&ageMax=\(ageMax)")
            
        }
        
    }
    func currentlocation(){
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                return
            }
            
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            self.NearByDict = NearBySearch.init(dictionary: NSDictionary())
            self.NearByDict?.latitude = currentLocation.coordinate.latitude
            self.NearByDict?.longitude = currentLocation.coordinate.longitude
            self.NearByDict?.range = "40000"
            getAllPosts(Name: (self.NearByDict?.range)!, lat: String(describing:currentLocation.coordinate.latitude), long: String(describing:currentLocation.coordinate.longitude))
        }
    }

    
    
    @IBAction func mBackBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func mFilterBtnAct(_ sender: Any) {
        
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "FiltersVCID") as! FiltersVC
        destinationvc.delegate = self
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    
    
 
    func getallUsers(type: String) {
        SVProgressHUD.show()
        UserAPI().getAllUsers(type: type){ (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                     self.refreshControl.endRefreshing()
                    self.nearByData.removeAll()
                    let nearlist = data[APIConstants.items.rawValue] as! NSArray
            
                    self.nearByData = NearBySearch.modelsFromDictionaryArray(array: nearlist)
                    self.mNearByTblCell.reloadData()
                   
                     SVProgressHUD.dismiss()
                }}
            else{
                SVProgressHUD.dismiss()
                print("Getting Error")
            }
             SVProgressHUD.dismiss()
        }
    }

    //MARK:- Api
    func getAllPosts(Name: String = "",lat: String = "", long:String = "") {
       
        QuestionAPI().getallSearchdetails(postId: Name, lat: lat, long: long) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{

                    self.nearByData.removeAll()
                    let nearlist = data[APIConstants.items.rawValue] as! NSArray

                    self.nearByData = NearBySearch.modelsFromDictionaryArray(array: nearlist)

                    self.mNearByTblCell.reloadData()
                    
                }}
            else{
            
                print("Getting Error")
            }
        }
    }
    func getfilterdata(latitude: String, longitude: String, range: String, filterBy: String, ageMin: String, ageMax: String) {
     
        QuestionAPI().getfilter(latitude: latitude, longitude: longitude, range: range, filterBy: filterBy, ageMin: ageMin, ageMax: ageMax){ (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
             
                    let nearlist = data[APIConstants.items.rawValue] as! NSArray
                   
                    
                    self.nearByData = NearBySearch.modelsFromDictionaryArray(array: nearlist)
          
                    self.mNearByTblCell.reloadData()
                    
                }
            }
            else{
           
                print("Getting Error")
            }
        }
    }
}


extension NearByVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.nearByData != nil{
        return self.nearByData.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearByTblCellID", for: indexPath) as! NearByTblCell
   
        cell.mMessageBtn.addTarget(self, action: #selector(mMessageBtnAct(sender:)), for: .touchUpInside)
        cell.mMessageBtn.tag = indexPath.row
        cell.mViewProfileBtn.addTarget(self, action: #selector(mViewProfile(sender:)), for: .touchUpInside)
        cell.mViewProfileBtn.tag = indexPath.row
        if self.nearByData[indexPath.row].name != nil{
        cell.mNameLbl.text = self.nearByData[indexPath.row].name
        }
        cell.mLabel1.text = self.nearByData[indexPath.row].address
        if  self.nearByData[indexPath.row].question?.count != 0 {
            cell.mLabel.text = self.nearByData[indexPath.row].question?[0]
        }
        else if self.nearByData[indexPath.row].question?.count == 0 {
            cell.mLabel.text = ""
        }
        
        

        let url = self.nearByData[indexPath.row].imgUrl
        if url != nil{
            let urlimage = URL(string: url!)
            cell.mImageView.sd_setImage(with: urlimage, placeholderImage: #imageLiteral(resourceName: "default_user_square"))
        }else{
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
        
    }
    @objc func mMessageBtnAct(sender: UIButton){
        let btnclick : Int = sender.tag
        
            let otherUserId = self.nearByData[btnclick].id
        //HANDLING NIL VALUE
         let otherusersname = self.nearByData[btnclick].name != nil ? String(describing: self.nearByData[btnclick].name!) : "NA"
        
            let otherUsername = otherusersname
            print(otherUserId!)
            let vc  = storyboard?.instantiateViewController(withIdentifier: "UserChatRoomVCID")as! UserChatRoomVC
            vc.opponentID = otherUserId!
            vc.opponentName = otherUsername
            if self.nearByData[btnclick].imgUrl != nil{
                let otherImgUrl = self.nearByData[btnclick].imgUrl
                vc.opponentImgUrl = otherImgUrl!
            }
            navigationController?.pushViewController(vc, animated: true)
            
    
    }
    @objc func mViewProfile(sender: UIButton){
        let btnclick : Int = sender.tag
        guard let otherUserId = self.nearByData[btnclick].id else {
            return
        }
        
             let vc  = storyboard?.instantiateViewController(withIdentifier: "OtherUserProfileVCID")as! OtherUserProfileVC
        
            vc.opponentId = otherUserId
            navigationController?.pushViewController(vc, animated: true)
            
        
    }
}


extension NearByVC : FiltersVCDelegate {
    func setFilterParameters(minimumRange: Double, maximumRange: Double, minimumAge: Int, maximumAge: Int, lati: Double, longi: Double, financialInterest: String) {
        
      self.getfilterdata(latitude: "latitude=\(String(lati))", longitude: "&longitude=\(String(longi))", range: "&range=\(String(maximumRange))", filterBy: "&filterBy=\(String(financialInterest))", ageMin: "&ageMin=\(String(minimumAge))", ageMax: "&ageMax=\(String(maximumAge))")
        
       
        

        
    }
    
  
    
    
}
