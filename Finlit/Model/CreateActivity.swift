//
//  CreateActivity.swift
//  SearchApp
//
//  Created by Gurpreet Gulati on 06/07/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation

enum CreateActivityAttributes :String {
    
    case name = "name"
    case priority = "priority"
    case locationName = "locationName"
    case budget = "budget"
    case date = "date"
    case fromTime = "fromTime"
    case toTime = "toTime"
    case id = "id"
    case routeNumber = "routeNumber"
    case locationCoordinates = "locationCoordinates"
    case folderName = "folderName"
    case invites = "invites"
    case folderId = "folderId"
    case categoryId = "categoryId"
    case folder = "folder"
    
    
    
    
    
    
    
    
    
    
    static let getAll = [
        name,
        priority,
        locationName,
        budget,
        date,
        fromTime,
        toTime,
        id,
        routeNumber,
        locationCoordinates,
        folderName,
        invites,
        folderId,
        categoryId,
        folder
        
    ]
}


public class CreateActivity {
    public var name : String?
    public var priority : String?
    public var locationName : String?
    public var budget : Int?
    public var date : String?
    public var fromTime : String?
    public var toTime : String?
    public var routeNumber : Int?
    public var id : Int?
    public var folderName : String?
    public var folderId : Int?
    public var categoryId : String?    
    public var locationCoordinates : [String]?
    public var invites : [User]?
    public var folder : Folder?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [CreateActivity]
    {
        var models:[CreateActivity] = []
        for item in array
        {
            models.append(CreateActivity(dictionary: item as! NSDictionary)!)
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
        
        name = dictionary["name"] as? String
        priority = dictionary["priority"] as? String
        locationName = dictionary["locationName"] as? String
        date = dictionary["date"] as? String
        fromTime = dictionary["fromTime"] as? String
        toTime = dictionary["toTime"] as? String
        budget = dictionary["budget"] as? Int
        id = dictionary["id"] as? Int
        routeNumber = dictionary["routeNumber"] as? Int
        locationCoordinates = dictionary["locationCoordinates"] as? [String]
        invites = dictionary["invites"] as? [User]
        folder = dictionary["folder"] as? Folder
        
        folderName = dictionary["folderName"] as? String
        folderId = dictionary["folderId"] as? Int
        categoryId = dictionary["categoryId"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.priority, forKey: "priority")
        dictionary.setValue(self.locationName, forKey: "locationName")
        dictionary.setValue(self.budget, forKey: "budget")
        dictionary.setValue(self.date, forKey: "date")
        dictionary.setValue(self.fromTime, forKey: "fromTime")
        dictionary.setValue(self.toTime, forKey: "toTime")
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.routeNumber, forKey: "routeNumber")
        dictionary.setValue(self.locationCoordinates, forKey: "locationCoordinates")
        dictionary.setValue(self.folderName, forKey: "folderName")
        dictionary.setValue(self.invites, forKey: "invites")
        
        dictionary.setValue(self.folder, forKey: "folder")
        
        dictionary.setValue(self.folderId, forKey: "folderId")
        dictionary.setValue(self.categoryId, forKey: "categoryId")
        
        return dictionary
    }
    
}
