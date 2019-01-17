//
//  RouteByID.swift
//  SearchApp
//
//  Created by Gurpreet Gulati on 04/08/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation


enum RouteByIDAttributes :String {
    
    
    case name = "name"
    case stepName = "stepName"
    case noOfTask = "noOfTask"
    case noOfTaskCompleted = "noOfTaskCompleted"
    case date = "date"
    case routeStatus = "routeStatus"
    case taskId = "taskId"
    case id = "id"
    case routeNumber = "routeNumber"
    case stepCoordinates = "stepCoordinates"
    case priority = "priority"
    case locationName = "locationName"
    case fromTime = "fromTime"
    case toTime = "toTime"
    case budget = "budget"
    case folderId = "folderId"
    case status = "status"
    case taskStatus = "taskStatus"
    case routeId = "routeId"
    case order = "order"
    case locationCoordinates = "locationCoordinates"
   
    
    
    
    
    
    
    
    
    static let getAll = [
        name,
        stepName,
        noOfTask,
        noOfTaskCompleted,
        date,
        routeStatus,
        taskId,
        id,
        routeNumber,
        stepCoordinates,
        priority,
        locationName,
        fromTime,
        toTime,
        budget,
        folderId,
        status,
        taskStatus,
        routeId,
        order,
        locationCoordinates
        
    ]
}


public class RouteByID {
    public var name : String?
    public var stepName: String?
    public var noOfTask: Int?
    public var noOfTaskCompleted: Int?
    public var date : String?
    public var routeStatus : String?
    public var taskId : [String]?
    public var routeNumber : Int?
    public var id : Int?
    public var stepCoordinates: [String]?
    public var priority : String?
    public var locationName : String?
    public var fromTime : String?
    public var toTime : String?
    public var budget : String?
    public var folderId : Int?
    public var status : String?
    public var taskStatus : String?
    public var routeId : Int?
    public var order : Int?
    public var locationCoordinates : [String]?
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [RouteByID]
    {
        var models:[RouteByID] = []
        for item in array
        {
            models.append(RouteByID(dictionary: item as! NSDictionary)!)
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
        stepName = dictionary["stepName"] as? String
        noOfTask = dictionary["noOfTask"] as? Int
        date = dictionary["date"] as? String
        routeStatus = dictionary["routeStatus"] as? String
        taskId = dictionary["taskId"] as? [String]
        noOfTaskCompleted = dictionary["noOfTaskCompleted"] as? Int
        id = dictionary["id"] as? Int
        routeNumber = dictionary["routeNumber"] as? Int
        stepCoordinates = dictionary["stepCoordinates"] as? [String]
        priority = dictionary["priority"] as? String
        locationName = dictionary["locationName"] as? String
        fromTime = dictionary["fromTime"] as? String
        toTime = dictionary["toTime"] as? String
        budget = dictionary["budget"] as? String
        folderId = dictionary["folderId"] as? Int
        status = dictionary["status"] as? String
        taskStatus = dictionary["taskStatus"] as? String
        routeId = dictionary["routeId"] as? Int
        order = dictionary["order"] as? Int
        locationCoordinates = dictionary["locationCoordinates"] as? [String]
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.stepName, forKey: "stepName")
        dictionary.setValue(self.noOfTask, forKey: "noOfTask")
        dictionary.setValue(self.noOfTaskCompleted, forKey: "noOfTaskCompleted")
        dictionary.setValue(self.date, forKey: "date")
        dictionary.setValue(self.routeStatus, forKey: "routeStatus")
        dictionary.setValue(self.taskId, forKey: "taskId")
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.routeNumber, forKey: "routeNumber")
        dictionary.setValue(self.stepCoordinates, forKey: "stepCoordinates")
        dictionary.setValue(self.priority, forKey: "priority")
        dictionary.setValue(self.locationName, forKey: "locationName")
        dictionary.setValue(self.fromTime, forKey: "fromTime")
        dictionary.setValue(self.toTime, forKey: "toTime")
        dictionary.setValue(self.budget, forKey: "budget")
        dictionary.setValue(self.folderId, forKey: "folderId")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.taskStatus, forKey: "taskStatus")
        dictionary.setValue(self.routeId, forKey: "routeId")
        dictionary.setValue(self.order, forKey: "order")
        dictionary.setValue(self.locationCoordinates, forKey: "locationCoordinates")
        
        
        
        return dictionary
    }
    
}
