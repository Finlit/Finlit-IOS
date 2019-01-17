//
//  CreateProfileVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 09/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation
import SwiftLocation



class CreateProfileVC: UIViewController, CLLocationManagerDelegate {
     var validator:Validators!
    
    @IBOutlet weak var mFintableView: UITableView!
    @IBOutlet weak var mBlackbtnOut: UIButton!
    @IBOutlet weak var mquestTableView: UITableView!
    
    @IBOutlet weak var mAge: UIView!
    @IBOutlet weak var mGender: UIView!
    @IBOutlet weak var mLocation: UIView!
    @IBOutlet weak var mWhatRU: UIView!
    @IBOutlet weak var mUsername: UIView!
    @IBOutlet weak var mName: UIView!
    @IBOutlet weak var mPassword: UIView!
    @IBOutlet weak var mAboutYou: UIView!
    @IBOutlet weak var mProceed: UIButton!
    @IBOutlet weak var mUserImage: UIImageView!
    @IBOutlet weak var mCoverImg: UIImageView!
    
    @IBOutlet weak var mNameTextField: UITextField!
    @IBOutlet weak var mGenderTextField: UITextField!
    
    @IBOutlet weak var mAgeTextField: UITextField!
    
    @IBOutlet weak var mLocationTextField: UITextField!
    
    @IBOutlet weak var mWhatRTextField: UITextField!
    
    @IBOutlet weak var mUserNameTextField: UITextField!
    @IBOutlet weak var mPasswordTextField: UITextField!
    @IBOutlet weak var maboutYouTextField: UITextField!
    
    var isFbLogin : Bool = false
    let Gender = ["male","female"]
    let Whatru = ["Credit Card Churning","Stock Trading","Real estate","Retirement planning","Budget planning","Personal investment","Futures/Forex Trading","Crypto Trading","Vacation planning"]
     var GenderpickerView = UIPickerView()
    var Whatrupickerview = UIPickerView()
     var locCor: [Double]!
      private var fileUploadAPI:FileUpload!
    var picUrl:String?
    var user:User?
    var LoctionDict : Location?
    var latDouble = Double()
    var lngDouble = Double()
    var CountArr = NSMutableArray()
    var whatsarr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        validator = Validators()
        self.fileUploadAPI = FileUpload.sharedInstance
        self.navigationController?.navigationBar.isHidden = true
        self.GenderpickerView.delegate = self
        self.GenderpickerView.dataSource = self
        self.Whatrupickerview.dataSource = self
        self.Whatrupickerview.delegate = self
        mFintableView.isHidden = true
        mBlackbtnOut.isHidden = true
        mGenderTextField.inputView = GenderpickerView
        mAgeTextField.inputView = Whatrupickerview
        
        self.mNameTextField.delegate = self
        self.mAgeTextField.delegate = self
        self.mGenderTextField.delegate = self
        self.mLocationTextField.delegate = self
        self.mAgeTextField.delegate = self
//        self.mUserNameTextField.delegate = self
        self.mPasswordTextField.delegate = self
        self.maboutYouTextField.delegate = self
        self.mUserImage.layer.cornerRadius = self.mUserImage.layer.frame.height / 2
        count()
        if self.isFbLogin == true {
            self.fillInputs()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let locate = Locator
        locate.currentPosition(accuracy: .city, onSuccess: {loc in
            print(loc.coordinate)
            Locator.api.googleAPIKey = remoteConfig.googleAPIKey
            let coordinates = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude)
            Locator.location(fromCoordinates: coordinates, using: .google, onSuccess: { places in
                print(places)
                
                DispatchQueue.main.async {
                    let place = places.first
                   // self.mLocationTextField.text = place?.formattedAddress!
                    if place != nil{
//                        self.locCor = [Double(place!.coordinates!.latitude),Double( place!.coordinates!.longitude)]
//                        self.latDouble = (place?.coordinates?.latitude)!
//                        self.lngDouble = (place?.coordinates?.longitude)!
                    //    print(self.latDouble)
                        
                    }
                    
                }
                
            }) { err in
                print(err)
            }
        }, onFail: {(e, b) -> (Void) in
            print("")
            
        })
    }
    
    
    func count(){
        for i in 16...100{
            let num = String(describing: i)
            CountArr.add(num)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    
    
    func fillInputs() {
        self.mNameTextField.text = user?.name
        self.mGenderTextField.text = user?.gender
        if  self.user?.imgUrl != nil {
            self.mUserImage.sd_setImage(with: URL.init(string:(user?.imgUrl!.httpsExtend)!), placeholderImage: #imageLiteral(resourceName: "cameraicon"))
            
        }
    }
    
    
    @IBAction func mWhtBtnAct(_ sender: Any) {
        mFintableView.isHidden = false
        mBlackbtnOut.isHidden = false
    }
    @IBAction func BlackbtnAct(_ sender: Any) {
         mFintableView.isHidden = true
        mBlackbtnOut.isHidden = true
    }
    
    @IBAction func mProceedTappedBtn(_ sender: UIButton) {
        guard validator.validators(TF1: self.mNameTextField,fieldName: "Name") == false
            || validator.validators(TF1: self.mAgeTextField,fieldName: "Age") == false
            || validator.validators(TF1: self.mGenderTextField,fieldName: "Gender") == false
            || validator.validators(TF1: self.mLocationTextField,fieldName: "Location") == false
            || validator.validators(TF1: self.mWhatRTextField,fieldName: "What are you doing in financial life?") == false
        
            || validator.validators(TF1: self.mPasswordTextField,fieldName: "Password") == false
            || validator.validators(TF1: self.maboutYouTextField,fieldName: "About You") == false

                else {
                    let isVaildPass:Bool = isValidated(mPasswordTextField.text!)
                    print(isVaildPass)
                    if isVaildPass == false{
                        print("wrong")
                         kAppDelegate.showNotification(text: "Please enter Minimum 6 Charcter")
                    }else{
                    self.LoctionDict = Location.init(dictionary: NSDictionary())

                    self.LoctionDict?.address = self.mLocationTextField.text
                    self.LoctionDict?.coordinates = locCor
                    print(self.LoctionDict?.coordinates!)

                    self.user = User.init(dictionary: NSDictionary())
                    self.user?.name = self.mNameTextField.text
                    self.user?.gender = self.mGenderTextField.text
                    self.user?.ageGroup = Int(self.mAgeTextField.text!)
                    self.user?.location = self.LoctionDict
                    self.user?.aboutUs = self.maboutYouTextField.text
                    self.user?.question  = self.mWhatRTextField.text
                    self.user?.password = self.mPasswordTextField.text
                 //   let idOfUser : String =  Constants.kUserDefaults.value(forKey: appConstants.userId) as! String
                 //   print (idOfUser)
                    self.user?.userId  =  Constants.kUserDefaults.value(forKey: appConstants.userId) as? String
                    print(self.user?.userId)


                    if picUrl != nil{
                        self.user?.picUrl = picUrl!
                    }
        
                 //   let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVCID") as! WelcomeVC
                   // self.navigationController?.pushViewController(destinationvc, animated: true)
                    
                    
                     self.userUpdateProfile(userDict: user!)
                    
                    
                    
                    }
                    
                return
        }
        
    
    }
    
    
    
    
    // MARK: User SignUp Function
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
                
                let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVCID") as! WelcomeVC
                self.navigationController?.pushViewController(destinationvc, animated: true)
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
    
    @IBAction func mBackBtn(_ sender: UIButton) {
     self.navigationController?.popViewController(animated: true)
    }
    
    
    func pickAddress() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func mAddProfilePicBtnTapped(_ sender: UIButton) {
        self.addImage()
    }
   
    func isValidated(_ password: String) -> Bool {
        if password.count  >= 6 {
           return true
        } else {
                return false
        }
        return false
    }
  
}

extension  CreateProfileVC: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == self.GenderpickerView {
            return Gender.count
        }
        
        return self.CountArr.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.GenderpickerView {
            return Gender[row]
        }
            
        else if pickerView == self.Whatrupickerview{
            
            return CountArr[row] as! String
        }
        return "empty"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.Whatrupickerview {
            self.mAgeTextField.text = CountArr[row] as! String
            self.mAgeTextField.resignFirstResponder()
        }
        else if pickerView == self.GenderpickerView{
            mGenderTextField.text = Gender[row]
            mGenderTextField.resignFirstResponder()
        }
        
        
    }
}



extension CreateProfileVC : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
            
        case self.mLocationTextField:
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
    
}




extension CreateProfileVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        self.mLocationTextField.text = place.formattedAddress
        print(self.mLocationTextField.text)
        print(place.formattedAddress)
        print(place.coordinate.longitude)
        self.locCor = [Double(place.coordinate.longitude),Double(place.coordinate.latitude)]
        
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

extension CreateProfileVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func addImage(){
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let takePic = UIAlertAction(title: "Take Photo", style: .default,handler: {
            (alert: UIAlertAction!) -> Void in
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = UIImagePickerControllerSourceType.camera
            self.present(myPickerController, animated: true, completion: nil)
            
        })
        
        let choseAction = UIAlertAction(title: "Choose from Library",style: .default,handler: {
            (alert: UIAlertAction!) -> Void in
            
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(takePic)
        optionMenu.addAction(choseAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("abc")
        guard let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        self.dismiss(animated: false, completion: { [weak self] in
            self?.mUserImage.image = originalImage
            self?.mCoverImg.image = originalImage
            self?.mCoverImg.alpha = 0.5
            
            //self?.bUserProfileImgOut.setBackgroundImage(originalImage, for: .normal)
            self?.moveToImageCropper(image: originalImage)
        })
    }
    
}


extension CreateProfileVC : CropViewControllerDelegate {
    
    private func moveToImageCropper(image: UIImage) {
        let cropController = CropViewController(croppingStyle: CropViewCroppingStyle.default, image: image)
        cropController.delegate = self
        cropController.aspectRatioPickerButtonHidden = true
        cropController.aspectRatioLockEnabled = true
        cropController.aspectRatioPreset = .presetSquare
        self.present(cropController, animated: true, completion: nil)
    }
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.mUserImage.contentMode = .scaleAspectFill
        self.mCoverImg.contentMode = .scaleAspectFill
        //self.bUserProfileImgOut.setBackgroundImage(image, for: .normal)
        
        
        let compressData = UIImageJPEGRepresentation(image, 0.5)
        let compressedImage = UIImage(data: compressData!)
        self.fileUploadAPI.uploadImageaaaRemote(image: compressedImage!){ dataImage, error -> Void in
            if error == nil{
                self.picUrl = dataImage
                Constants.kUserDefaults.set(dataImage, forKey: appConstants.UserImage)
            }

        }
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
}
extension CreateProfileVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
        return self.Whatru.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhatsTableViewCellID", for: indexPath) as! WhatsTableViewCell
      
        cell.mlabel.text = self.Whatru[indexPath.row]
        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "WhatsTableViewCell2ID", for: indexPath) as! WhatsTableViewCell
            cell.mCancelBtn.addTarget(self, action: #selector(mMessageBtnAct(sender:)), for: .touchUpInside)
            cell.mCancelBtn.tag = indexPath.row
            cell.mDonebtn.addTarget(self, action: #selector(mViewProfile(sender:)), for: .touchUpInside)
            cell.mDonebtn.tag = indexPath.row
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
        return 52
        }else{
            return 73
        }
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = mFintableView.cellForRow(at: indexPath)as! WhatsTableViewCell
        cell.mImg.image = #imageLiteral(resourceName: "pinkTick")
        print(indexPath.row)
       let textstr = self.Whatru[indexPath.row]
        whatsarr.add(textstr)
        let seprt = whatsarr.componentsJoined(by: ",")
        mWhatRTextField.text = seprt
      //  mFintableView.isHidden = true
     //   mBlackbtnOut.isHidden = true
       
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = mFintableView.cellForRow(at: indexPath)as! WhatsTableViewCell
        cell.mImg.image = nil
        let textstr = self.Whatru[indexPath.row]
        print(textstr)
        whatsarr.remove(textstr)
        print(whatsarr)
        let seprt = whatsarr.componentsJoined(by: ",")
        mWhatRTextField.text = seprt
    }
    @objc func mMessageBtnAct(sender: UIButton){
     //   let btnclick : Int = sender.tag
        mFintableView.isHidden = true
        mBlackbtnOut.isHidden = true
        
    }
    @objc func mViewProfile(sender: UIButton){
       // let btnclick : Int = sender.tag
        mFintableView.isHidden = true
        mBlackbtnOut.isHidden = true
        
    }
}







