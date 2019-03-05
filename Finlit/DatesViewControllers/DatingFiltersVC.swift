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
    
    func sendAgeRangeValues(minAgeValue:Int,maxAgeValue:Int)
    func sendLocationRangeValues(minLocRangeValue:Int,maxLocRangeValue:Int)
    
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
       
        if self.minAgeVar != 0 && maxAgeVar != 0{
       self.delegate?.sendAgeRangeValues(minAgeValue: minAgeVar, maxAgeValue: maxAgeVar)
            self.navigationController?.popViewController(animated: true)
            
        
        }
        
        if self.minDistVar != 0 && maxDistVar != 0{
            self.delegate?.sendLocationRangeValues(minLocRangeValue: minDistVar, maxLocRangeValue: maxDistVar)
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        if sender == mAgeSlider {
            self.minAgeVar = Int(selectedMinimum)
             self.maxAgeVar = Int(selectedMaximum)
           
            return
        }
        
       else if sender == mLocRangeSlider {
            self.minDistVar = Int(selectedMinimum)
            self.maxDistVar = Int(selectedMaximum)

            return
            
        }
    }
    
}
