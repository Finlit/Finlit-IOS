//
//  Location.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 01/11/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import Foundation


enum LocationAttributes :String {
    
    
    case address = "address"
    case coordinates = "coordinates"
    
    
    
    
    
    
    
    static let getAll = [
        address,
        coordinates
        
    ]
}


public class Location {
    public var address : String?

    public var coordinates: [Double]?
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Location]
    {
        var models:[Location] = []
        for item in array
        {
            models.append(Location(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let User = User(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: User Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        address = dictionary["address"] as? String
      
        coordinates = dictionary["coordinates"] as? [Double]
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.address, forKey: "address")
        dictionary.setValue(self.coordinates, forKey: "coordinates")
        return dictionary
    }
    
}
