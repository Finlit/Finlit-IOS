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
    
    var userMdlVar : User?
    var secondUserDetails : User?
    var locCor: [String]!
    let DateTimepicker = UIDatePicker()
    var sendbuttonFrame = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.createDatePicker()
        self.setupUI()
        self.mLocationTxtFld.delegate = self
        self.mTimeTxtFld.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
    }
    
    func changeSendBtn() {
        sendbuttonFrame.size.width = sendbuttonFrame.width + 60
        let btnProfile = UIButton(frame: self.sendbuttonFrame)
        btnProfile.setTitle("Send", for: .normal)
        btnProfile.layer.borderColor = UIColor.white.cgColor
        btnProfile.backgroundColor = UIColor.pinkThemeColor()
        btnProfile.layer.cornerRadius = 4.0
        btnProfile.layer.masksToBounds = true
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: btnProfile)]
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
        
    
    
        
    }
    
    
    
    
    func setupUI(){
        self.sendbuttonFrame = self.mSendBtnOutl.accessibilityFrame
        self.mUserImage1.layer.cornerRadius = mUserImage1.frame.height / 2
        self.mUserImg2.layer.cornerRadius = mUserImage1.frame.height / 2
        self.mUserImage1.clipsToBounds = true
        self.mUserImg2.clipsToBounds = true
        let font = UIFont.systemFont(ofSize: 16)
        mCancelBtn.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedStringKey.font.rawValue): font], for: .normal)
        mLocationTxtFld.attributedPlaceholder = NSAttributedString(string: "Choose Location", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
         mTimeTxtFld.attributedPlaceholder = NSAttributedString(string: "Choose Date & Time", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        
        
        if fetchProfileFromPresistance() == true{
            if self.userMdlVar!.imgUrl != nil {
                self.mUserImage1.sd_setImage(with: URL.init(string:(self.userMdlVar!.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
                
            else {
                if let userid = Constants.kUserDefaults.value(forKey: appConstants.userId){
                    self.getUserDetail(UserID: userid as! String)
                }}
        }
        
        
        
        if self.secondUserDetails != nil {
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
    
    
    
    
    
    
    
    func getUserDetail(UserID:String){
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
            self.changeSendBtn()
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
        let dateString =  DateTimepicker.date.dateToSmartDate
        let timeString = DateTimepicker.date.dateToSmartTime
        //let dateString = formatter.string(from: DOBpicker.date)
        self.mTimeTxtFld.text = "\(dateString)" + " @ " + "\(timeString)"
        self.view.endEditing(true)
        
    }
}




