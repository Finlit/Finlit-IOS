////
////  TxtFld.swift
////  Pheemee
////
////  Created by Gurpreet Gulati on 20/09/18.
////  Copyright © 2018 Gurpreet Gulati. All rights reserved.
////
//
//import Foundation
//
//private var maxLengths = [UITextField: Int]()
//
//extension UITextField {
//    @IBInspectable var maxLength: Int {
//        get {
//            guard let length = maxLengths[self] else {
//                return Int.max
//            }
//            return length
//        }
//        set {
//            maxLengths[self] = newValue
//            addTarget(
//                self,
//                action: #selector(limitLength),
//                for: UIControlEvents.editingChanged
//            )
//        }
//    }
//    
//    @objc func limitLength(textField: UITextField) {
//        guard let prospectiveText = textField.text,
//            prospectiveText.count > maxLength
//            else {
//                return
//        }
//        
//        let selection = selectedTextRange
//        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
//        
//        text = prospectiveText.suffix(to: maxCharIndex)
//        selectedTextRange = selection
//    }
//}

