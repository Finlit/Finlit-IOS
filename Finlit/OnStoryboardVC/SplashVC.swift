//
//  SplashVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 08/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var mFindDateSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if Constants.kUserDefaults.value(forKey: appConstants.findMeADate) != nil {
            if  Constants.kUserDefaults.value(forKey: appConstants.findMeADate) as! Bool == false {
                mFindDateSwitch.isOn = false
            }
                
            else {
                mFindDateSwitch.isOn = true
            }
            
        }
        
     
        
        
        self.mFindDateSwitch.transform = CGAffineTransform(scaleX: 0.60, y: 0.60)
        self.mFindDateSwitch.onTintColor = UIColor.switchSeaGreenColor()
     
    }
    
    
    
    @IBAction func mDateSwitchToggled(_ sender: UISwitch) {
        if sender.isOn == false {
            Constants.kUserDefaults.setValue(false, forKey: appConstants.findMeADate)
        }
            
        else {
            Constants.kUserDefaults.setValue(true, forKey: appConstants.findMeADate)
            
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
                        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "DatesVCID") as! DatesVC
                        self.navigationController?.pushViewController(destinationvc, animated: true)
            

        }
     
    }
    



}
