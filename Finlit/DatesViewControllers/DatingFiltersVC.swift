//
//  DatingFiltersVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 03/03/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit
import TTRangeSlider



protocol DatingFiltersVCDelegate: class {
    
    func sendRangeValues(minAgeValue:Int,maxAgeValue:Int,minLocRangeValue:Int,maxLocRangeValue:Int)
    
}

class DatingFiltersVC: UIViewController,TTRangeSliderDelegate {

  weak var delegate : DatingFiltersVCDelegate?
    @IBOutlet weak var mLocRangeSlider: TTRangeSlider!
    @IBOutlet weak var mAgeSlider: TTRangeSlider!
    var maxAgeVar : Int = 0
    var minAgeVar : Int = 0
    var minDistVar: Int = 0
    var maxDistVar : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        mAgeSlider.delegate = self
         mLocRangeSlider.delegate = self
        self.navigationController?.navigationBar.isHidden = false

        
     
    }
    


    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func mTickBtnTapped(_ sender: UIBarButtonItem) {
         self.delegate?.sendRangeValues(minAgeValue: minAgeVar, maxAgeValue: maxAgeVar, minLocRangeValue: minDistVar, maxLocRangeValue: maxDistVar)
    }
    
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        if sender == mAgeSlider {
            self.minAgeVar = Int(selectedMinimum)
             self.maxAgeVar = Int(selectedMaximum)
           
//            print("min age value is\(String(describing: minAgeVar))")
//            print("max age value is\(String(describing: maxAgeVar))")
            return
        }
        
       else if sender == mLocRangeSlider {
            self.minDistVar = Int(selectedMinimum)
            self.maxDistVar = Int(selectedMaximum)
//            print("min dist value is\(String(describing: minDistVar))")
//            print("max dist value is\(String(describing: maxDistVar))")
            return
            
        }
    }
    
}
