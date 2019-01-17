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
    var filterUrl = NSMutableArray()
    var filterBy = String()
    var addressStr = String()
    var lat = Double()
    var long = Double()
    override func viewDidLoad() {
        super.viewDidLoad()

        mBoolCheck = true
        mBoolCheck1 = true
        mBoolCheck2 = true
        mBoolCheck3 = true
        mBoolCheck4 = true
        mBoolCheck5 = true
        mBoolCheck6 = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func mAllFiterByBtnAct(_ sender: UIButton) {
        resetbtn2()
        switch sender.tag {
        case 0:
            if mBoolCheck == true{

             //   resetbtn()
                mBoolCheck = false
            }else{
             //    resetbtn2()

                mBoolCheck = true
            }
            
            break
        case 1:
//            if mBoolCheck1 == true{
                 filterBy = "Real Estate"
//                filterUrl.add(filterBy)
//                 print(filterUrl)
                mRealbtnOut.setTitleColor(.white, for: .normal)
                mRealbtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
//                 mBoolCheck1 = false
//            }else{
//                filterBy = "Real Estate"
//                filterUrl.remove(filterBy)
//                print(filterUrl)
//                mRealbtnOut.backgroundColor = .clear
//                mRealbtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
//                mBoolCheck1 = true
//            }
           
            
            break
            
        case 2:
//            if mBoolCheck2 == true{
                 filterBy = "Retirements"
//                filterUrl.add(filterBy)
//                print(filterUrl)
                mRetirementBtnOut.setTitleColor(.white, for: .normal)
                mRetirementBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
//                mBoolCheck2 = false
//            }else{
//                 filterBy = "Retirements"
//                filterUrl.remove(filterBy)
//                print(filterUrl)
//                mRetirementBtnOut.backgroundColor = .clear
//                mRetirementBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
//                mBoolCheck2 = true
//            }
            
            
            break
        case 3:
//            if mBoolCheck3 == true{
                filterBy = "CC Cruncching"
//                filterUrl.add(filterBy)
//                print(filterUrl)
                mCCCrngBtnOut.setTitleColor(.white, for: .normal)
                mCCCrngBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
//                mBoolCheck3 = false
//            }else{
//                filterBy = "CC Cruncching"
//                filterUrl.remove(filterBy)
//                print(filterUrl)
//                mCCCrngBtnOut.backgroundColor = .clear
//                mCCCrngBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
//                mBoolCheck3 = true
//            }
           
            break
        case 4:
//            if mBoolCheck4 == true{
                filterBy = "Budget Planing"
//                filterUrl.add(filterBy)
//                print(filterUrl)
                mBudgetBtnOut.setTitleColor(.white, for: .normal)
                mBudgetBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
//                mBoolCheck4 = false
//            }else{
//                filterBy = "Budget Planing"
//                filterUrl.remove(filterBy)
//                print(filterUrl)
//                mBudgetBtnOut.backgroundColor = .clear
//                mBudgetBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
//                mBoolCheck4 = true
//            }
//
          
            break
        case 5:
           // if mBoolCheck5 == true{
                filterBy = "Personal Investment"
               
//                filterUrl.add(filterBy)
//                print(filterUrl)
                mPersonalBtnOut.setTitleColor(.white, for: .normal)
                mPersonalBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
//                mBoolCheck5 = false
//            }else{
//
//               filterBy = "Personal Investment"
//                filterUrl.remove(filterBy)
//                print(filterUrl)
//                mPersonalBtnOut.backgroundColor = .clear
//                mPersonalBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
//                mBoolCheck5 = true
//            }
            
          
            break
        case 6:
//            if mBoolCheck6 == true{
                filterBy = "Cyptocurency"
//
//                filterUrl.add(filterBy)
//                print(filterUrl)
                mLastBtnOut.setTitleColor(.white, for: .normal)
                mLastBtnOut.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.5764705882, alpha: 1)
//                mBoolCheck6 = false
//            }else{
//                filterBy = "Cyptocurency"
//                filterUrl.remove(filterBy)
//                print(filterUrl)
//                mLastBtnOut.backgroundColor = .clear
//                mLastBtnOut.setTitleColor(#colorLiteral(red: 0.2602087259, green: 0.6764962673, blue: 0.9224001765, alpha: 1), for: .normal)
//                mBoolCheck6 = true
//            }
//
            break
        default:
            break
        }
        
    }
    func resetbtn(){
//        var RemoveArray : [String]?
//        filterBy = "Real Estate, Retirements, CC Cruncching, Budget Planing, Personal Investment, Cyptocurency"
//        filterUrl.remove(filterBy)
//        filterBy = "Real Estate, Retirements, CC Cruncching, Budget Planing, Personal Investment, Cyptocurency"
//        filterUrl.add(filterBy)
//         print(filterUrl)
//        RemoveArray = (filterUrl as! [String])
//        print(RemoveArray!)
       // let removeDuplicatearr = RemoveArray?.uniq()
       // print(removeDuplicatearr!)
       
       // for
        
        
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
//        filterBy = "Real Estate,Retirements,CC Cruncching,Budget Planing,Personal Investment,Cyptocurency"
//        filterUrl.remove(filterBy)
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
//        mBoolCheck = true
//        mBoolCheck1 = true
//        mBoolCheck2 = true
//        mBoolCheck3 = true
//        mBoolCheck4 = true
//        mBoolCheck5 = true
//        mBoolCheck6 = true
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
            mAgeMax = Int((selectedMaximum))
            mAgeMin = Int((selectedMaximum))
        }else{
            print(selectedMaximum)
            print(selectedMinimum)
            mMaxRange = Double(selectedMaximum) * 1600
        }
    }
    
}
