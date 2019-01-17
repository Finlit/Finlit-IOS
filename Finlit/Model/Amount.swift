//
//  Amount.swift
//  SearchApp
//
//  Created by Gurpreet Gulati on 11/07/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */


enum AmountAttributes: String {
    
    case categoryId = "categoryId"
    case description = "description"
    case amount  = "amount "
   
    
    
    static let getAll = [
        categoryId,
        description,
        amount
    ]
    
}



public class Amount {
    public var categoryId : Int?
    public var description : String?
    public var amount : Int?
   
    
   
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Amount]
    {
        var models:[Amount] = []
        for item in array
        {
            models.append(Amount(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Amount = Amount(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Amount Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        categoryId = dictionary["categoryId"] as? Int
        description = dictionary["description"] as? String
        amount = dictionary["amount"] as? Int
      
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.categoryId, forKey: "categoryId")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.amount, forKey: "amount")
       
        
        return dictionary
    }
    
}
