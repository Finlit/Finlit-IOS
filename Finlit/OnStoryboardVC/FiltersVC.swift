//
//  FiltersVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 15/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import TTRangeSlider




protocol FiltersVCDelegate: class {
    
    func setFilterParameters(minimumRange:Double,maximumRange:Double, minimumAge:Int, maximumAge:Int, lati:Double,longi:Double, financialInterest : String)
    
}




class FiltersVC: UIViewController {
  var locCor = [Double]()
    
    
    @IBOutlet weak var mRangeSlider: TTRangeSlider!
    @IBOutlet weak var mAgeSlider: TTRangeSlider!
    @IBOutlet weak var mLastBtnOut: UIButton!
    @IBOutlet weak var mPersonalBtnOut: UIButton!
    @IBOutlet weak var mBudgetBtnOut: UIButton!
    @IBOutlet weak var mCCCrngBtnOut: UIButton!
    @IBOutlet weak var mRetirementBtnOut: UIButton!
    @IBOutlet weak var mRealbtnOut: UIButton!
    @IBOutlet weak var mAllbtnOut: UIButton!
    @IBOutlet weak var mLocationTextField: UITextField!
    
    var mBoolCheck = Bool()
    var mBoolCheck1 = Bool()
    var mBoolCheck2 = Bool()
    var mBoolCheck3 = Bool()
    var mBoolCheck4 = Bool()
    var mBoolCheck5 = Bool()
    var mBoolCheck6 = Bool()
    var mAgeMax = Int()
    var mAgeMin = Int()
    var mMaxRange = Double()
    var mMinRange = Double()
    var filterUrl = NSMutableArray()
    var filterBy = String()
    var addressStr = String()
    var lat = Double()
    var long = Double()
    
    
     weak var delegate : FiltersVCDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.title = "FILTERS"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        mBoolCheck = true
        mBoolCheck1 = true
        mBoolCheck2 = true
        mBoolCheck3 = true
        mBoolCheck4 = true
        mBoolCheck5 = true
        mBoolCheck6 = true
    }


    
    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mApplyBtnAct(_ sender: Any) {
       
        let vc = storyboard?.instantiateViewController(withIdentifier: "NearByVCID")as! NearByVC
        vc.filterbyStr = filterBy
        vc.ageMax = String(describing: mAgeMax)
        vc.ageMin = String(describing: mAgeMin)
        vc.latStr = String(describing: lat)
        vc.longStr = String(describing: long)
        vc.rangeStr = String(describing: mMaxRange)
        vc.VCcheckInt = 1
        //navigationController?.pushViewController(vc, animated: true)
        self.delegate?.setFilterParameters(minimumRange: self.mMinRange, maximumRange: self.mMaxRange, minimumAge: self.mAgeMin, maximumAge: self.mAgeMax, lati: self.lat, longi: self.long, financialInterest: self.filterBy)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    @IBAction func mAllFiterByBtnAct(_ sender: UIButton) {
        resetbtn2()
        switch sender.tag {
        case 0:
            if mBoolCheck == true{

        mAllbtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
                mBoolCheck = false
            }else{
     

                mBoolCheck = true
            }
            
            break
        case 1:

                 filterBy = "Real estate"

                mRealbtnOut.setTitleColor(.white, for: .normal)
                mRealbtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)

           
            
            break
            
        case 2:

                 filterBy = "Retirement planning"

                mRetirementBtnOut.setTitleColor(.white, for: .normal)
                mRetirementBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)

            
            
            break
        case 3:

                filterBy = "Credit Card Churning"

                mCCCrngBtnOut.setTitleColor(.white, for: .normal)
                mCCCrngBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)

           
            break
        case 4:

                filterBy = "Budget planning"

                mBudgetBtnOut.setTitleColor(.white, for: .normal)
                mBudgetBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)


          
            break
        case 5:
       
                filterBy = "Personal investment"
               

                mPersonalBtnOut.setTitleColor(.white, for: .normal)
                mPersonalBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)

            
          
            break
        case 6:

                filterBy = "Cryptocurrency Trading"


                mLastBtnOut.setTitleColor(.white, for: .normal)
                mLastBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)

            break
        default:
            break
        }
        
    }
    func resetbtn(){

        
        
         mAllbtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
         mRealbtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
         mRetirementBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
         mCCCrngBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
         mBudgetBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
         mPersonalBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
         mLastBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
        
         mAllbtnOut.setTitleColor(.white, for: .normal)
         mRealbtnOut.setTitleColor(.white, for: .normal)
         mRetirementBtnOut.setTitleColor(.white, for: .normal)
         mCCCrngBtnOut.setTitleColor(.white, for: .normal)
         mBudgetBtnOut.setTitleColor(.white, for: .normal)
         mPersonalBtnOut.setTitleColor(.white, for: .normal)
         mLastBtnOut.setTitleColor(.white, for: .normal)
        mBoolCheck = false
        mBoolCheck1 = false
        mBoolCheck2 = false
        mBoolCheck3 = false
        mBoolCheck4 = false
        mBoolCheck5 = false
        mBoolCheck6 = false
    }
    func resetbtn2(){

        mAllbtnOut.backgroundColor = .clear
        mRealbtnOut.backgroundColor = .clear
        mRetirementBtnOut.backgroundColor = .clear
        mCCCrngBtnOut.backgroundColor = .clear
        mBudgetBtnOut.backgroundColor = .clear
        mPersonalBtnOut.backgroundColor = .clear
        mLastBtnOut.backgroundColor = .clear
        
        mAllbtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
        mRealbtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
        mRetirementBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
        mCCCrngBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
        mBudgetBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
        mPersonalBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
        mLastBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)

    }
    func uniqueElementsFrom(array: [String]) -> [String] {
        //Create an empty Set to track unique items
        var set = Set<String>()
        let result = array.filter {
            guard !set.contains($0) else {
                //If the set already contains this object, return false
                //so we skip it
                return false
            }
            //Add this item to the set since it will now be in the array
            set.insert($0)
            //Return true so that filtered array will contain this item.
            return true
        }
        return result
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func pickAddress() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
}
extension FiltersVC : UITextFieldDelegate {
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
extension FiltersVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        self.mLocationTextField.text = place.formattedAddress
        print(self.mLocationTextField.text)
        print(place.formattedAddress)
        self.long = Double(place.coordinate.longitude)
        self.lat = Double(place.coordinate.latitude)
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
extension FiltersVC : TTRangeSliderDelegate{
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        if sender == mAgeSlider{
        print(selectedMaximum)
        print(selectedMinimum)
            self.mAgeMax = Int((selectedMaximum))
            self.mAgeMin = Int((selectedMaximum))
        }else{
            print(selectedMaximum)
            print(selectedMinimum)
            self.mMaxRange = Double(selectedMaximum) * 1600
            self.mMinRange = Double(selectedMinimum) * 1600
        }
    }
    
}
