//
//  SavedRoute.swift
//  SearchApp
//
//  Created by Gurpreet Gulati on 21/05/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation

enum SavedRouteAttributes :String {
    
    
    case routeName = "routeName"
   case stepName = "stepName"
    case locationName = "locationName"
    case picUrl = "picUrl"
    case time = "time"
    case routeStatus = "routeStatus"
    case taskId = "taskId"
    case id = "id"
    case routeNumber = "routeNumber"
    case stepCoordinates = "stepCoordinates"
    
    
    
    
    
    
    
    static let getAll = [
        routeName,
        stepName,
        locationName,
        picUrl,
        time,
        routeStatus,
        taskId,
        id,
        routeNumber,
        stepCoordinates
        
    ]
}


public class SavedRoute {
    public var routeName : String?
    public var stepName: String?
    public var locationName: String?
    public var picUrl: String?
    public var time : String?
    public var routeStatus : String?
    public var taskId : String?
    public var routeNumber : Int?
    public var id : Int?
    public var stepCoordinates: [String]?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [SavedRoute]
    {
        var models:[SavedRoute] = []
        for item in array
        {
            models.append(SavedRoute(dictionary: item as! NSDictionary)!)
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
        
        routeName = dictionary["routeName"] as? String
        stepName = dictionary["stepName"] as? String
        locationName = dictionary["locationName"] as? String
        time = dictionary["time"] as? String
        routeStatus = dictionary["routeStatus"] as? String
        taskId = dictionary["taskId"] as? String
        picUrl = dictionary["picUrl"] as? String
        id = dictionary["id"] as? Int
        routeNumber = dictionary["routeNumber"] as? Int
        stepCoordinates = dictionary["stepCoordinates"] as? [String]
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.routeName, forKey: "routeName")
        dictionary.setValue(self.stepName, forKey: "stepName")
        dictionary.setValue(self.locationName, forKey: "locationName")
        dictionary.setValue(self.picUrl, forKey: "picUrl")
        dictionary.setValue(self.time, forKey: "time")
        dictionary.setValue(self.routeStatus, forKey: "routeStatus")
        dictionary.setValue(self.taskId, forKey: "taskId")
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.routeNumber, forKey: "routeNumber")
        dictionary.setValue(self.stepCoordinates, forKey: "stepCoordinates")
        return dictionary
    }
    
}
