//
//  Order.swift
//  SearchApp
//
//  Created by Gurpreet Gulati on 22/05/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation


enum OrderAttributes: String {
    
    case id = "id"
    case name = "name"
    case phone  = "phone "
    case role = "role"
    case totalActivities  = "totalActivities"
    case order  = "order"
    case noOfTask  = "noOfTask"
    
    
    static let getAll = [
        id,
        name,
        phone ,
        role,
        totalActivities,
        order,
        noOfTask
    ]
    
}

public class Order {
    public var id : Int?
    public var name : String?
    public var phone  : String?
    public var role : String?
    public var totalActivities  : String?
    public var order  : Int?
    public var noOfTask  : Int?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Folder_list = Folder.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Folder Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Order]
    {
        var models:[Order] = []
        for item in array
        {
            models.append(Order(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Folder = Folder(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Folder Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        phone  = dictionary["phone "] as? String
        role = dictionary["role"] as? String
        totalActivities  = dictionary["totalActivities"] as? String
        order  = dictionary["order"] as? Int
        noOfTask = dictionary["noOfTask"] as? Int
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.phone , forKey: "phone ")
        dictionary.setValue(self.role, forKey: "role")
        dictionary.setValue(self.totalActivities, forKey: "totalActivities")
        dictionary.setValue(self.order, forKey: "order")
        dictionary.setValue(self.noOfTask, forKey: "noOfTask")
        
        
        return dictionary
    }
    
}
