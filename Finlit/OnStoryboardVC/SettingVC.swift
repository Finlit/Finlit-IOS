//
//  SettingVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 16/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import Toast_Swift

class SettingVC: UIViewController {
let Gender = ["male","female"]
var GenderpickerView = UIPickerView()
    var GenderType : String?
    @IBOutlet weak var mGenderTextField: UITextField!
    
    @IBOutlet weak var mNotificationsSwitch: UISwitch!
    @IBOutlet weak var mSoundSwitch: UISwitch!
    @IBOutlet weak var mFindMeDateSwitch: UISwitch!
     var currentGenderOnPicker : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createDoneButtonForPickers()
        
        if  Constants.kUserDefaults.value(forKey: appConstants.findMeADate) != nil {
            if  Constants.kUserDefaults.value(forKey: appConstants.findMeADate) as! Bool == false {
                mFindMeDateSwitch.isOn = false
            }
                
            else {
                mFindMeDateSwitch.isOn = true
            }
            
        }
      
      
        mGenderTextField.inputView = GenderpickerView
      self.GenderpickerView.delegate = self
        GenderpickerView.showsSelectionIndicator = true
        self.setupSwitchUI()
    }
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
        
        if Constants.kUserDefaults.value(forKey: appConstants.selecttype) as? String != nil {
            
            mGenderTextField.text = Constants.kUserDefaults.value(forKey: appConstants.selecttype) as! String
            
        }
        
        
        
    }
    
    
    
    @IBAction func mDateSwitchToggled(_ sender: UISwitch) {
        if sender.isOn == false {
             Constants.kUserDefaults.setValue(false, forKey: appConstants.findMeADate)
        }
        
        else {
             Constants.kUserDefaults.setValue(true, forKey: appConstants.findMeADate)
            
        }
    }
    
    
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5,y: UIScreen.main.bounds.size.height*0.5)
//        self.view.makeToastActivity(frameSize)
//        self.view.hideToastActivity()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func setupSwitchUI () {
        self.mNotificationsSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        self.mSoundSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        self.mFindMeDateSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        
     
        
        self.mNotificationsSwitch.onTintColor = UIColor.switchSeaGreenColor()
        self.mSoundSwitch.onTintColor = UIColor.switchSeaGreenColor()
        self.mFindMeDateSwitch.onTintColor = UIColor.switchSeaGreenColor()
    
        
    }
    
    
    

    @IBAction func mBackBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func mAllButtonAct(_ sender: UIButton) {
        switch sender.tag {
//        case 0:
//            let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "QuickQuizVCID") as! QuickQuizVC
//            destinationvc.VCcheck = 0
//            self.navigationController?.pushViewController(destinationvc, animated: true)
//            break
        
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "UpdatePasswordVCID")as! UpdatePasswordVC
            navigationController?.pushViewController(vc, animated: true)
            break

        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "BlockedUsersVCID")as! BlockedUsersVC
            navigationController?.pushViewController(vc, animated: true)
            break
            
            
        case 3:
            let vc = storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsVCID")as! TermsAndConditionsVC
            navigationController?.pushViewController(vc, animated: true)
            break
            
        case 4:
            let vc = storyboard?.instantiateViewController(withIdentifier: "SupportVCID")as! SupportVC
            navigationController?.pushViewController(vc, animated: true)
            break
            
        case 5:
            let vc = storyboard?.instantiateViewController(withIdentifier: "PrivacyVCID")as! PrivacyVC
            navigationController?.pushViewController(vc, animated: true)
            break
            
            
        case 6:
            
            Constants.kUserDefaults.set(nil, forKey: appConstants.profile)
            Constants.kUserDefaults.set(nil, forKey: appConstants.token)
            Constants.kUserDefaults.set(nil, forKey: appConstants.id)
            Constants.kUserDefaults.set("logout", forKey: UserAttributes.status.rawValue)
            let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVCID")as! SignUpVC
            let isProfileCompleted = Constants.kUserDefaults.bool(forKey: UserAttributes.isProfileCompleted.rawValue)
            if isProfileCompleted == true {
                Constants.kUserDefaults.set(false, forKey: UserAttributes.isProfileCompleted.rawValue)
            }else{
                Constants.kUserDefaults.set(false, forKey: UserAttributes.isProfileCompleted.rawValue)
            }
            navigationController?.pushViewController(vc, animated: true)
            break

        default:
            break
        }
        
    }
    
}
extension  SettingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       
        return self.Gender.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        self.currentGenderOnPicker = Gender[row]
            return Gender[row]
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
            mGenderTextField.text = Gender[row]
        Constants.kUserDefaults.set(mGenderTextField.text!, forKey: appConstants.selecttype)
            mGenderTextField.resignFirstResponder()

        }
    
    
    
    
    func createDoneButtonForPickers() {
        let toolbarForGenderPicker = UIToolbar()
        toolbarForGenderPicker.sizeToFit()

        let doneForGender = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForGenderPicker))
        toolbarForGenderPicker.setItems([doneForGender], animated: false)
        
        mGenderTextField.inputAccessoryView = toolbarForGenderPicker
        mGenderTextField.inputView = GenderpickerView
        
   
    }
    
    @objc func donePressedForGenderPicker() {
        mGenderTextField.text = self.currentGenderOnPicker
         Constants.kUserDefaults.set(mGenderTextField.text!, forKey: appConstants.selecttype)
        self.view.endEditing(true)
        return
    }
    
        
        
    
}
