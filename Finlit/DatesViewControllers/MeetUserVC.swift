//
//  MeetUserVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 13/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit
import GooglePlaces
import Toast_Swift
class MeetUserVC: UIViewController {

    @IBOutlet weak var mSendBtnOutl: UIBarButtonItem!
    @IBOutlet weak var mCancelBtn: UIBarButtonItem!
    @IBOutlet weak var mUserImage1: UIImageView!
    @IBOutlet weak var mUserImg2: UIImageView!
    @IBOutlet weak var mLocationTxtFld: UITextField!
    @IBOutlet weak var mTimeTxtFld: UITextField!
    
    var myImgUrl : String?
    var userMdlVar : User?
    var secondUserDetails : User?
    var locCor: [String]!
    let DateTimepicker = UIDatePicker()
    var sendbuttonFrame = CGRect()
    var datesAPI : DatesAPI!
    var toUserId : String = ""
    var userDict : User?
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datesAPI = DatesAPI.sharedInstance
        
        if fetchProfileFromPresistance() == true{
            if self.userMdlVar!.imgUrl != nil {
                self.mUserImage1.sd_setImage(with: URL.init(string:(self.userMdlVar!.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
                
            else {
                if let userid = Constants.kUserDefaults.value(forKey: appConstants.userId){
                    self.getMyProfileDetails(UserID: userid as! String)
                }}
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.createDatePicker()
        self.setupUI()
  
        //changeSendBtnToWhite()
        self.mLocationTxtFld.delegate = self
        self.mTimeTxtFld.delegate = self
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
    }
    

    
    
    func changeSendBtnToPink() {
        sendbuttonFrame.size.width = sendbuttonFrame.width + 60
        let btnProfile = UIButton(frame: self.sendbuttonFrame)
        btnProfile.setTitle("Send", for: .normal)
        btnProfile.setTitleColor(UIColor.white, for: .normal)
        btnProfile.titleLabel?.font =  .systemFont(ofSize: 14)
        btnProfile.layer.borderColor = UIColor.lightGray.cgColor
        btnProfile.backgroundColor = UIColor.pinkThemeColor()
        btnProfile.layer.cornerRadius = 4.0
        btnProfile.layer.masksToBounds = true
        btnProfile.addTarget(self, action: #selector(sendBtnAction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: btnProfile)]
    }
    
    @objc  func sendBtnAction () {
   
        if self.mLocationTxtFld.text?.count == 0 {
    self.view.makeToast("Select a Location")
    return
    }
    
    if self.mTimeTxtFld.text?.count == 0 {
    self.view.makeToast("Select a Time")
    return
    }
    
    self.userDict = User.init(dictionary: NSDictionary())
    if self.mLocationTxtFld.text != nil || self.mTimeTxtFld.text != "" {
    userDict?.location?.address = self.mLocationTxtFld.text
    var dateInString = self.selectedDate.stringOfDateandTimefromDateType
        var dateInUTC = dateInString.dateStringToUTCString
    userDict?.createdAt = dateInUTC
    self.sendDateRequest(userDict: userDict!) //API
    
    
    }
    
    }
    
    
    
    
    
    @IBAction func mSendBtnTapped(_ sender: UIBarButtonItem) {
        if self.mLocationTxtFld.text?.count == 0 {
            self.view.makeToast("Select a Location")
            return
        }
        
        if self.mTimeTxtFld.text?.count == 0 {
            self.view.makeToast("Select a Time")
            return
        }
        
        self.userDict = User.init(dictionary: NSDictionary())
        if self.mLocationTxtFld.text != nil || self.mTimeTxtFld.text != "" {
            userDict?.location?.address = self.mLocationTxtFld.text
            userDict?.createdAt = self.selectedDate.stringfromDateType.dateStringToUTCString
                self.sendDateRequest(userDict: userDict!)
        

        
        }}
    
    
    func pushBackToDatesVC() {
        for vc in (self.navigationController?.viewControllers ?? []) {
            if vc is DatesVC {
                _ = self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    
    
    
    
    
    func setupUI(){
        self.sendbuttonFrame = self.mSendBtnOutl.accessibilityFrame
        self.mUserImage1.layer.cornerRadius = mUserImage1.frame.height / 2
        self.mUserImg2.layer.cornerRadius = mUserImg2.frame.height / 2
        self.mUserImage1.clipsToBounds = true
        self.mUserImg2.clipsToBounds = true
        let font = UIFont.systemFont(ofSize: 16)
        mCancelBtn.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedStringKey.font.rawValue): font], for: .normal)
        mLocationTxtFld.attributedPlaceholder = NSAttributedString(string: "Choose Location", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
         mTimeTxtFld.attributedPlaceholder = NSAttributedString(string: "Choose Date & Time", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        
        
   
        
        
        
        if self.secondUserDetails != nil {
            self.toUserId = (secondUserDetails?.id)!
            self.navigationItem.title = "MEET " + (secondUserDetails?.name?.capitalized)!
            if self.secondUserDetails!.imgUrl != nil {
                self.mUserImg2.sd_setImage(with: URL.init(string:(self.secondUserDetails!.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
        }
        
        
    }
    
    

    func fetchProfileFromPresistance() -> Bool {
        if let profile = UserDefaults.standard.data(forKey: appConstants.profile){
            let userDict = NSKeyedUnarchiver.unarchiveObject(with: profile)
            let myProfile = User.init(dictionary: userDict as! NSDictionary)
            self.userMdlVar = myProfile
            return true
        }
        
        
        return false
        
    }

    
    
    

    @IBAction func mCancelTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func pickAddress() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    // MARK: Send Date Request
    func sendDateRequest(userDict:User)
        
    {
                SVProgressHUD.show(withStatus: "Please Wait")
        datesAPI.sendDateRequest(toUserID: self.toUserId, dateDetials: userDict){ (isSuccess,data, error) -> Void in
            SVProgressHUD.dismiss()
            if (isSuccess){
                SVProgressHUD.dismiss()
                self.view.makeToast("Request Sent Successfully")
                self.pushBackToDatesVC()
                
                
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
    
    
    
    
    
    
    
    func getMyProfileDetails(UserID:String){
        UserAPI().getUserDetails(userId: UserID, pageNo: 1) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    let userlist = data[APIConstants.data.rawValue] as! NSDictionary
                    self.userMdlVar = User.init(dictionary: userlist)
                    self.mUserImage1.sd_setImage(with: URL.init(string:(self.userMdlVar!.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
            }
            else{
                print("Getting Error")
            }
        }
        
    }
    
    
    
}


extension MeetUserVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        self.mLocationTxtFld.text = place.formattedAddress
        self.locCor = [String(describing: place.coordinate.latitude),String(describing: place.coordinate.longitude)]
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}



extension MeetUserVC :UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //self.changeSendBtn(btnBackgColor: UIColor.white)
        switch textField {
            
        case self.mLocationTxtFld:
            self.pickAddress()
            return false
            
        default:
            print("abc")
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count != 0 {
            self.changeSendBtnToPink()
        }
    }
    
}

extension MeetUserVC {
    //DATEPicker
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(DATEdonePressed))
        toolbar.setItems([done], animated: true)
        self.mTimeTxtFld.inputAccessoryView = toolbar
        self.mTimeTxtFld.inputView = DateTimepicker
        DateTimepicker.datePickerMode = .dateAndTime
        DateTimepicker.minimumDate = Date()
    }
    
    @objc func DATEdonePressed() {
        //formatdate
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        self.selectedDate = DateTimepicker.date
        let dateString =  DateTimepicker.date.dateToSmartDate
        let timeString = DateTimepicker.date.dateToSmartTime
        //let dateString = formatter.string(from: DOBpicker.date)
        self.mTimeTxtFld.text = "\(dateString)" + " @ " + "\(timeString)"
        self.view.endEditing(true)
        
    }
}




