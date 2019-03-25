//
//  Notification.swift
//  Pheemee
//
//  Created by Gurpreet Gulati on 01/10/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation
enum NotificationAttributes: String {
    
    case id = "id"
    case title = "title"
    case description = "description"
    case entityName = "entityName"
    case entityId = "entityId"
    case dataName = "dataName"
    case dataId = "dataId"
    case imgUrl = "imgUrl"
    case createdAt = "createdAt"
}

public class Notification {
    public var id : Int?
    public var title : String?
    public var description : String?
    public var entityName : String?
    public var entityId : String?
    public var dataName : String?
    public var dataId : Int?
    public var imgUrl : String?
    public var createdAt : String?
     public var user : User?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let json4Swift_Base_list = Notification.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Notification Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Notification]
    {
        var models:[Notification] = []
        for item in array
        {
            models.append(Notification(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let json4Swift_Base = Notification(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Notification Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        title = dictionary["title"] as? String
        description = dictionary["description"] as? String
        entityName = dictionary["entityName"] as? String
        entityId = dictionary["entityId"] as? String
        dataName = dictionary["dataName"] as? String
        dataId = dictionary["dataId"] as? Int
        imgUrl = dictionary["imgUrl"] as? String
        createdAt = dictionary["createdAt"] as? String
            if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as! NSDictionary) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.entityName, forKey: "entityName")
        dictionary.setValue(self.entityId, forKey: "entityId")
        dictionary.setValue(self.dataName, forKey: "dataName")
        dictionary.setValue(self.dataId, forKey: "dataId")
        dictionary.setValue(self.imgUrl, forKey: "imgUrl")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
        
        return dictionary
    }
    
}
