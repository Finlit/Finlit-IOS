//
//  Countryyy.swift
//  Pheemee
//
//  Created by Gurpreet Gulati on 23/08/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation


enum CountryyAttributes: String {
    
    case id = "id"
    case name = "name"
    
    
    
    static let getAll = [
        id,
        name
        
    ]
    
}

public class Countryy {
    public var id : String?
    public var name : String?
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Countryy_list = Countryy.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Countryy Instances.
     */
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Countryy]
    {
        var models:[Countryy] = []
        for item in array
        {
            models.append(Countryy(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Countryy = Countryy(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Countryy Instance.
     */
    
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
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

