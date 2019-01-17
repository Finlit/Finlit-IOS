//
//  Route.swift
//  SearchApp
//
//  Created by Gurpreet Gulati on 19/05/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation

enum RouteAttributes :String {
   
    
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
        stepCoordinates
        
    ]
}


public class Route {
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
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Route]
    {
        var models:[Route] = []
        for item in array
        {
            models.append(Route(dictionary: item as! NSDictionary)!)
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
        return dictionary
    }
    
}
