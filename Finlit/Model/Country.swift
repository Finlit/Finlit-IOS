//
//  Country.swift
//  Pheemee
//
//  Created by Gurpreet Gulati on 23/08/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

enum CountryAttributes: String {
    
    case id = "id"
    case name = "name"
    
    
    
    static let getAll = [
        id,
        name
        
    ]
    
}

public class Country {
    public var id : Int?
    public var name : String?
   
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Country_list = Country.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Country Instances.
     */
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Country]
    {
        var models:[Country] = []
        for item in array
        {
            models.append(Country(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Country = Country(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Country Instance.
     */
    
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
      
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.name, forKey: "name")
       
        return dictionary
    }
    
}

