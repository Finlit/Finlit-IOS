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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5,y: UIScreen.main.bounds.size.height*0.5)
//        self.view.makeToastActivity(frameSize)
//        self.view.hideToastActivity()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func setupSwitchUI () {
        self.mNotificationsSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.mSoundSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
     
        
        self.mNotificationsSwitch.onTintColor = UIColor.pinkThemeColor()
        self.mSoundSwitch.onTintColor = UIColor.pinkThemeColor()
    
        
    }
    
    
    

    @IBAction func mBackBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func mAllButtonAct(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "QuickQuizVCID") as! QuickQuizVC
            destinationvc.VCcheck = 0
            self.navigationController?.pushViewController(destinationvc, animated: true)
            break
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "UpdatePasswordVCID")as! UpdatePasswordVC
            navigationController?.pushViewController(vc, animated: true)
            break

        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "BlockedUsersVCID")as! BlockedUsersVC
            navigationController?.pushViewController(vc, animated: true)
            break
            
            
        case 3:
            
            break
        case 4:
            
            break
            
        case 5:
            
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
       
            return Gender[row]
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
            mGenderTextField.text = Gender[row]
        Constants.kUserDefaults.set(mGenderTextField.text!, forKey: appConstants.selecttype)
            mGenderTextField.resignFirstResponder()
     (Constants.kUserDefaults.value(forKey: appConstants.selecttype) as! String)
        }
        
        
    
}
