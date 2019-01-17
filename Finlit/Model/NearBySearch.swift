//
//  NearBySearch.swift
//  Finlit
//
//  Created by Tech Farmerz on 12/11/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import Foundation


enum NearBySearchAttributes :String {
    
    
    case latitude = "latitude"
    case longitude = "longitude"
    case range = "range"
    case question = "question"
    
   
    static let getAll = [
        latitude,
        longitude,
        range,
        question
    ]
}


public class NearBySearch {
    public var latitude : Double?
    
    public var longitude: Double?
    public var range: String?
    public var imgUrl: String?
    public var name: String?
    public var address: String?
    public var id: String?
    public var profileType: String?
    public var question: Array<String>?
    public var aboutUs: String?
    public var ageGroup: Int?
    
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [NearBySearch]
    {
        var models:[NearBySearch] = []
        for item in array
        {
            models.append(NearBySearch(dictionary: item as! NSDictionary)!)
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
        
        latitude = dictionary["latitude"] as? Double
        
        longitude = dictionary["longitude"] as? Double
        range = dictionary["range"] as? String
        imgUrl = dictionary["imgUrl"] as? String
        name = dictionary["name"] as? String
        if dictionary["location"] != nil{
        let location = dictionary["location"] as? NSDictionary
           if location!["address"] != nil{
           address = location!["address"] as? String
            }
        }
        id = dictionary["id"] as? String
        profileType = dictionary["profileType"] as? String
        aboutUs = dictionary["aboutUs"] as? String
        
        question = dictionary["question"] as? [String]
        
        //let questarr = dictionary["question"]as? NSArray
//        if questarr != nil {
//            question = questarr?.object(at: 0) as? String
//        }

        ageGroup = dictionary["ageGroup"] as? Int
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.latitude, forKey: "latitude")
        dictionary.setValue(self.longitude, forKey: "longitude")
        dictionary.setValue(self.range, forKey: "range")
        dictionary.setValue(self.question, forKey: "question")
        return dictionary
    }
    
}
