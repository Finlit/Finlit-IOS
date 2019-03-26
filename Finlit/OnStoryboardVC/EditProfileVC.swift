//
//  EditProfileVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 21/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import GooglePlaces
import SDWebImage
import Toast_Swift

class EditProfileVC: UIViewController {
    @IBOutlet weak var mNameTextField: UITextField!
    @IBOutlet weak var mAgeTextField: UITextField!
    @IBOutlet weak var mGenderTextField: UITextField!
    @IBOutlet weak var mLocationTextField: UITextField!
    @IBOutlet weak var mWhatRUTextField: UITextField!
    @IBOutlet weak var mAboutYouTextField: UITextField!
    @IBOutlet weak var mCoverProfileImg: UIImageView!
    @IBOutlet weak var mprofileImgs: UIImageView!
    
    @IBOutlet weak var mEdittableView: UITableView!
    
    @IBOutlet weak var mBlackbtnOut: UIButton!
    @IBOutlet weak var mDoneBtnOut: UIButton!
    
    var currentGenderOnPicker : String?
    var currentAgeOnPicker : String?
    let ageValuesArry = Array(16...100)
    let Gender = ["male","female"]
    let Whatru = ["Credit Card Churning","Stock Trading","Real estate","Retirement planning","Budget planning","Personal investment","Futures/Forex Trading","Cryptocurrency Trading","Vacation planning"]
    var QuestionArr = ["What common interests would you like to share with other members?","Who are you looking for?","What is your eye color?","What is your hair color?","What is your faith?","What’s your level of education?","How often do you exercise?","Do you smoke?","How often do you drink?","Do you have any kids?","Do you want children?","What’s your current annual income?","What are you saving for?","What kind of exercise do you enjoy?"]
    var GenderpickerView = UIPickerView()
    var Whatrupickerview = UIPickerView()
    var agesPickerView = UIPickerView()
    var locCor: [Double]!
    private var fileUploadAPI:FileUpload!
    var picUrl:String?
    var user:User?
    private var userApi : UserAPI!
    var LoctionDict : Location?
    var latDouble = Double()
    var lngDouble = Double()
    var indexInt = Int()
     var checkarrMenu = NSMutableArray()

    var interestArr : [InterestModel]!
    var interestDict : InterestModel!
    
    var interestMdlArryForAlreadyAnsweredQuests : [InterestModel]!
    var indexPathsOfSelectedQuestions = [IndexPath]()
    var answersDictionary = [IndexPath:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mNameTextField.delegate = self
//        self.mAgeTextField.delegate = self
//        self.mGenderTextField.delegate = self
        self.mLocationTextField.delegate = self
        //self.mWhatRUTextField.delegate = self
        self.mAboutYouTextField.delegate = self
        
        self.userApi = UserAPI.sharedInstance
        interestArr = [InterestModel]()
        interestDict = InterestModel.init(dictionary: NSDictionary())
        self.interestMdlArryForAlreadyAnsweredQuests = [InterestModel]()
        
      
        
        self.fileUploadAPI = FileUpload.sharedInstance
        self.GenderpickerView.delegate = self
        self.GenderpickerView.dataSource = self
        self.Whatrupickerview.dataSource = self
        self.Whatrupickerview.delegate = self
        self.agesPickerView.delegate = self
        self.agesPickerView.dataSource =  self
       
        mGenderTextField.inputView = GenderpickerView
        mWhatRUTextField.inputView = Whatrupickerview
        mAgeTextField.inputView = agesPickerView
       
        mBlackbtnOut.isHidden = true
        mEdittableView.isHidden = true
        mDoneBtnOut.isHidden = true
      
        let userId = Constants.kUserDefaults.value(forKey: appConstants.userId) as? String
        self.getUserDetail(UserID:userId!)
        self.createDoneButtonForPickers()
        self.mCoverProfileImg.alpha = 0.7
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    func putdataTofields(){
        let url = self.user?.imgUrl
       
        if url != nil{
            let urlimage = URL(string: url!)
            print(urlimage)
            SDImageCache.shared().clearMemory()
            SDImageCache.shared().clearDisk()
            Constants.kUserDefaults.set(url, forKey: appConstants.UserImage)
            mprofileImgs.sd_setImage(with: urlimage, placeholderImage: #imageLiteral(resourceName: "cameraicon"))
            mCoverProfileImg.sd_setImage(with: urlimage, placeholderImage: #imageLiteral(resourceName: "squareimage"))
        }
        
        mGenderTextField.text = user?.gender
        mWhatRUTextField.text = user?.question
        mLocationTextField.text = user?.address
        
        if user?.ageGroup != nil {
            mAgeTextField.text! = String(describing: user!.ageGroup!)
        }
     
        mNameTextField.text = user?.name
        mGenderTextField.text = user?.gender
        mAboutYouTextField.text = user?.aboutUs
        
        self.interestMdlArryForAlreadyAnsweredQuests = user?.interest
        
        if self.interestMdlArryForAlreadyAnsweredQuests != nil || self.interestMdlArryForAlreadyAnsweredQuests.count != 0 {
            for i in self.interestMdlArryForAlreadyAnsweredQuests {
                self.interestArr.append(i)
                
            }
            self.getIndexPathsAndAnswersOfAlreadyAnsweredQuests()
        }
        
        self.mEdittableView.delegate = self
        self.mEdittableView.dataSource = self
       
    }
    
    
    func getIndexPathsAndAnswersOfAlreadyAnsweredQuests() {
       
            for i in interestMdlArryForAlreadyAnsweredQuests! {
                if self.QuestionArr.contains(i.question!) {
                    let indexOfContainingQues = QuestionArr.firstIndex(of: i.question!)
                    let indexPathOfContainingQuestion = IndexPath(row: indexOfContainingQues!, section: 0)
                    self.indexPathsOfSelectedQuestions.append(indexPathOfContainingQuestion)
                    self.answersDictionary[indexPathOfContainingQuestion] = i.answer
                    
                    print("The index of the containing question is \(String(describing: indexOfContainingQues))")
                }
                
            }
        }
    
    
    
    
    @IBAction func mInterestBtnAct(_ sender: Any) {
        mBlackbtnOut.isHidden = false
        mEdittableView.isHidden = false
        mDoneBtnOut.isHidden = false
    }
    @IBAction func mBackBtn(_ sender: UIButton) {
       self.navigationController?.popViewController(animated: true)
    }
    @IBAction func meditBtnAct(_ sender: Any) {
        self.addImage()
        
    }
    
    @IBAction func mDoneBtnAct(_ sender: Any) {
        mBlackbtnOut.isHidden = true
        mEdittableView.isHidden = true
        mDoneBtnOut.isHidden = true
        user?.interest = interestArr
        self.user?.userId = Constants.kUserDefaults.value(forKey: appConstants.userId) as? String
   
        
    }
    
    @IBAction func mProccedBtnAct(_ sender: Any) {
        self.LoctionDict = Location.init(dictionary: NSDictionary())
        self.LoctionDict?.address = self.mLocationTextField.text
        self.LoctionDict?.coordinates = [latDouble,lngDouble]
        self.user = User.init(dictionary: NSDictionary())
        self.user?.name = self.mNameTextField.text
        self.user?.gender = self.mGenderTextField.text
        self.user?.ageGroup = Int(self.mAgeTextField.text!)
        self.user?.location = self.LoctionDict
        self.user?.aboutUs = self.mAboutYouTextField.text
        self.user?.question  = self.mWhatRUTextField.text
        self.user?.userId  =  Constants.kUserDefaults.value(forKey: appConstants.userId) as? String
        if picUrl != nil{
            self.user?.picUrl = nil
            self.user?.picUrl = picUrl!
            print("Pic URL is \(String(describing: picUrl))")
        }
        
        self.user?.interest = interestArr
        
        self.userUpdateProfile(userDict: user!)
    }
    
    
    
    
    // MARK: User SignUp Function
    func userUpdateProfile(userDict:User)
        
    {
        SVProgressHUD.show(withStatus: "Please Wait")
        UserAPI().userUpdateProfile(userDetials: userDict){ (isSuccess,response, error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                SVProgressHUD.dismiss()
                self.view.makeToast("Profile Updated Successfully")
                Constants.kUserDefaults.set("active", forKey: UserAttributes.status.rawValue)
                //self.performSegue(withIdentifier: "segueToHome", sender: self)
              // let userId = Constants.kUserDefaults.value(forKey: appConstants.userId) as? String
                  self.navigationController?.popViewController(animated: true)
                //self.getUserDetail(UserID:userId!)

                
                //                let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCID") as! HomeVC
//                self.navigationController?.pushViewController(destinationvc, animated: true)
                return
                
                
                
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
    func getUserDetail(UserID:String){
        userApi.getUserDetails(userId: UserID, pageNo: 1) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                 
                   //self.user = nil
                  
                    self.user =  User.init(dictionary: NSDictionary())
                    let userlist = data[APIConstants.data.rawValue] as! NSDictionary
                    print(userlist)

                    self.user = User.init(dictionary: userlist)
                    self.putdataTofields()
                  
                }}
            else{
              
                print("Something went wrong in getUserDetail API")
               self.view.makeToast("Something went wrong!")
            }
        }
        
    }
    
  
    
    func pickAddress() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
 
} //CLASS CLOSED

//PICKER VIEW DELEGATES SETUP
extension  EditProfileVC: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == self.GenderpickerView {
            return Gender.count
        }
        
        else if pickerView == self.agesPickerView {
            return ageValuesArry.count
        }
        
        return self.Whatru.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.GenderpickerView {
            self.currentGenderOnPicker = Gender[row]
            return Gender[row]
        }
            
            
        else if pickerView == self.agesPickerView{
            self.currentAgeOnPicker = String(describing:ageValuesArry[row])
            return String(describing:ageValuesArry[row])
        }
            
        else {
            return Whatru[row]
        }
     
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.Whatrupickerview {
            self.mWhatRUTextField.text = Whatru[row]
            self.mWhatRUTextField.resignFirstResponder()
        }
        else if pickerView == self.GenderpickerView{
            self.currentGenderOnPicker = Gender[row]
            mGenderTextField.text = Gender[row]
            mGenderTextField.resignFirstResponder()
        }
        
        else if pickerView == self.agesPickerView {
            self.currentAgeOnPicker = String(describing:ageValuesArry[row])
            mAgeTextField.text = String(describing:ageValuesArry[row])
            mAgeTextField.resignFirstResponder()
        }
        
        
    }
    
    
    func createDoneButtonForPickers() {
        let toolbarForGenderPicker = UIToolbar()
        toolbarForGenderPicker.sizeToFit()
        
        let toolbarForAgePicker = UIToolbar()
        toolbarForAgePicker.sizeToFit()
        
        let doneForGender = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForGenderPicker))
        toolbarForGenderPicker.setItems([doneForGender], animated: false)
        
        
        let doneForAge = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForAgePicker))
        toolbarForAgePicker.setItems([doneForAge], animated: false)
        
        mGenderTextField.inputAccessoryView = toolbarForGenderPicker
        mGenderTextField.inputView = GenderpickerView
        
        mAgeTextField.inputAccessoryView = toolbarForAgePicker
        mAgeTextField.inputView = agesPickerView
        
        
//        mWhatRUTextField.inputAccessoryView = toolbar
//        mWhatRUTextField.inputView = Whatrupickerview
        
        
    }
    
    
    @objc func donePressedForGenderPicker() {
            mGenderTextField.text = self.currentGenderOnPicker
             self.view.endEditing(true)
            return
        }
        
    
        @objc func donePressedForAgePicker() {
                mAgeTextField.text = self.currentAgeOnPicker
                self.view.endEditing(true)
                return
    }
    
    
    
}
    









extension EditProfileVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        self.mLocationTextField.text = place.formattedAddress
        print(self.mLocationTextField.text)
        print(place.formattedAddress)
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

extension EditProfileVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
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
            self?.mprofileImgs.image = originalImage
            self?.mCoverProfileImg.image = originalImage
            self?.mCoverProfileImg.alpha = 0.5
            
            //self?.bUserProfileImgOut.setBackgroundImage(originalImage, for: .normal)
            self?.moveToImageCropper(image: originalImage)
        })
    }
    
}


extension EditProfileVC : CropViewControllerDelegate {
    
    private func moveToImageCropper(image: UIImage) {
        let cropController = CropViewController(croppingStyle: CropViewCroppingStyle.default, image: image)
        cropController.delegate = self
        cropController.aspectRatioPickerButtonHidden = true
        cropController.aspectRatioLockEnabled = true
        cropController.aspectRatioPreset = .presetSquare
        self.present(cropController, animated: true, completion: nil)
    }
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.mprofileImgs.contentMode = .scaleAspectFill
        self.mCoverProfileImg.contentMode = .scaleAspectFill
       
        let compressData = UIImageJPEGRepresentation(image, 0.5)
        let compressedImage = UIImage(data: compressData!)
        SVProgressHUD.show()
        self.fileUploadAPI.uploadImageaaaRemote(image: compressedImage!){ dataImage, error -> Void in
            if error == nil{
                self.picUrl = dataImage
                print(dataImage)
                SVProgressHUD.dismiss()
            }else{
                SVProgressHUD.dismiss()
            }
            
        }
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
}


//TABLEVIEW DELEGATE METHODS AND SETUP
extension EditProfileVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return QuestionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCellID2", for: indexPath) as! EditProfileTableViewCell
         cell.mtxtfld?.delegate = self
         cell.mtxtfld?.tag = indexPath.row
         cell.mCheckbtn.tag = indexPath.row
        
         cell.mtxtfld.setLeftPaddingPoints(10)
            cell.mlbl2.text = QuestionArr[indexPath.row]
            cell.mCheckbtn.addTarget(self, action: #selector(checkbtn(sender:)), for: .touchUpInside)
      
        if checkarrMenu.contains([indexPath]){
            cell.mImg2.image = #imageLiteral(resourceName: "pinkTick")
            cell.mtxtfld.isHidden = false
            cell.mlbl2.frame.size.height = 32
            cell.mBottomConstant.constant = 16
        }
            
            

        if self.indexPathsOfSelectedQuestions.contains(indexPath){
            cell.mImg2.image = #imageLiteral(resourceName: "pinkTick")
            cell.mtxtfld.isHidden = false
            cell.mlbl2.frame.size.height = 32
            cell.mBottomConstant.constant = 16
//            cell.mtxtfld.isUserInteractionEnabled = false

            if self.answersDictionary.keys.contains(indexPath){
                cell.mtxtfld.text = self.answersDictionary[indexPath]
            }}
            
        
        
        else{
            cell.mImg2.image = nil
            cell.mtxtfld.isHidden = true
            cell.mlbl2.frame.size.height = 0
            cell.mBottomConstant.constant = -16
        }
            return cell
        
    }
   

    
    @objc func checkbtn(sender: UIButton){
        
        let touchPoint: CGPoint = sender.convert(CGPoint.zero, to: mEdittableView)
        // maintable --> replace your tableview name
        let clickedButtonIndexPath = mEdittableView.indexPathForRow(at: touchPoint)
        if checkarrMenu.contains([clickedButtonIndexPath]){
            checkarrMenu.remove([clickedButtonIndexPath])
            
            
        }
        
        else{
            checkarrMenu.add([clickedButtonIndexPath])
            self.indexInt = (clickedButtonIndexPath?.row)!
        }
        
        
        let indexPosition = IndexPath(row: (clickedButtonIndexPath?.row)!, section: 0)
        mEdittableView.reloadRows(at: [indexPosition], with: .none)
    }

}


extension EditProfileVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
            
        case self.mLocationTextField:
            self.pickAddress()
            return false
            
        default:
            print("Inside didbeginediting default case of switch")
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    
 
    
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Inside text field should end editing delegate method")
         let index = IndexPath(row: indexInt, section: 0)
        print(index)
        let cell = mEdittableView.cellForRow(at: index) as? EditProfileTableViewCell
        let answertext = cell?.mtxtfld.text
        let ques = QuestionArr[index.row]
        self.interestDict.question = ques
        self.interestDict.answer = answertext!
        interestArr.append(interestDict)
        self.interestDict = InterestModel.init(dictionary: NSDictionary())
        return true
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
   
}
