//
//  Folder.swift
//  SearchApp
//
//  Created by Gurpreet Gulati on 16/05/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//


import Foundation



enum FolderAttributes: String {
    
    case id = "id"
    case name = "name"
    case imgUrl  = "imgUrl "
    case totalEvents = "totalEvents"
    case totalActivities  = "totalActivities"
    case noOfTaskCompleted  = "noOfTaskCompleted"
    case noOfTask  = "noOfTask"
    
    
    static let getAll = [
        id,
        name,
        imgUrl ,
        totalEvents,
        totalActivities,
        noOfTaskCompleted,
        noOfTask
    ]
    
}

public class Folder {
    public var id : Int?
    public var name : String?
    public var imgUrl  : String?
    public var totalEvents : String?
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
    public class func modelsFromDictionaryArray(array:NSArray) -> [Folder]
    {
        var models:[Folder] = []
        for item in array
        {
            models.append(Folder(dictionary: item as! NSDictionary)!)
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
        imgUrl  = dictionary["imgUrl "] as? String
        totalEvents = dictionary["totalEvents"] as? String
        totalActivities  = dictionary["totalActivities"] as? String
        noOfTaskCompleted  = dictionary["noOfTaskCompleted"] as? Int
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
        dictionary.setValue(self.imgUrl , forKey: "imgUrl ")
        dictionary.setValue(self.totalEvents, forKey: "totalEvents")
        dictionary.setValue(self.totalActivities, forKey: "totalActivities")
        dictionary.setValue(self.noOfTaskCompleted, forKey: "noOfTaskCompleted")
        dictionary.setValue(self.noOfTask, forKey: "noOfTask")
        
        
        return dictionary
    }
    
}

