//
//  Invites.swift
//  SearchApp
//
//  Created by Gurpreet Gulati on 22/05/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation

enum InvitesAttributes: String {
    
    case id = "id"
    case name = "name"
    case phone  = "phone "
    case role = "role"
    case totalActivities  = "totalActivities"
    case noOfTaskCompleted  = "noOfTaskCompleted"
    case noOfTask  = "noOfTask"
    
    
    static let getAll = [
        id,
        name,
        phone ,
        role,
        totalActivities,
        noOfTaskCompleted,
        noOfTask
    ]
    
}

public class Invites {
    public var id : Int?
    public var name : String?
    public var phone  : String?
    public var role : String?
    public var totalActivities  : String?
    public var noOfTaskCompleted  : Int?
    public var noOfTask  : Int?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Folder_list = Folder.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Folder Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Invites]
    {
        var models:[Invites] = []
        for item in array
        {
            models.append(Invites(dictionary: item as! NSDictionary)!)
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
        noOfTaskCompleted  = dictionary["noOfTaskCompleted"] as? Int
        noOfTaskCompleted = dictionary["noOfTask"] as? Int
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
        dictionary.setValue(self.noOfTaskCompleted, forKey: "noOfTaskCompleted")
        dictionary.setValue(self.noOfTask, forKey: "noOfTask")
        
        
        return dictionary
    }
    
}
