//
//  Budget.swift
//  SearchApp
//
//  Created by Gurpreet Gulati on 05/07/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation


enum BudgetAttributes: String {
    
    case id = "id"
    case name = "name"
    case budget = "budget"
    case description = "description"
    case categoryId  = "categoryId"
    case amount  = "amount"
    case totalSpent  = "totalSpent"
    
    
    static let getAll = [
        id,
        name,
        budget,
        description,
        categoryId,
        amount,
        totalSpent
    ]
    
}

public class Budget{
    public var id : Int?
    public var name : String?
    public var budget : Int?
    public var description : String?
    public var categoryId  : String?
    public var amount  : Int?
    public var totalSpent  : Int?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Budget_list = Budget.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Budget Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Budget]
    {
        var models:[Budget] = []
        for item in array
        {
            models.append(Budget(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Budget = Budget(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Budget Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        budget = dictionary["budget"] as? Int
        description = dictionary["description"] as? String
        categoryId  = dictionary["categoryId"] as? String
        amount  = dictionary["amount"] as? Int
        totalSpent = dictionary["totalSpent"] as? Int
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.budget, forKey: "budget")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.categoryId, forKey: "categoryId")
        dictionary.setValue(self.amount, forKey: "amount")
        dictionary.setValue(self.totalSpent, forKey: "totalSpent")
        
        
        return dictionary
    }
    
}

