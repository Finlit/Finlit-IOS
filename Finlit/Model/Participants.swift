//
//  Participants.swift
//  Finlit
//
//  Created by Tech Farmerz on 15/11/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import Foundation
enum ParticipantsAttributtes :String {
    case
    
    userId = "userId",
    name = "name"
    static let getAll = [
        
        userId,
        name
    ]
}
public class Participants {
    public var unreadCount : Int?
    public var isBlocked : Int?
    public var isAdmin : Int?
    public var user : User?
    public var userId : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Post_list = Post.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Post Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Participants]
    {
        var models:[Participants] = []
        for item in array
        {
            models.append(Participants(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Post = Post(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Post Instance.
     */
    required public init?(dictionary: NSDictionary) {
        print(dictionary)
        //
        isAdmin = dictionary["isAdmin"] as? Int
        print(isAdmin)
        isBlocked = dictionary["isBlocked"] as? Int
        unreadCount = dictionary["unreadCount"] as? Int
       
        if dictionary["user"] != nil{
            let userid = dictionary["user"] as? NSDictionary
            userId = userid!["id"] as? String
            print(userId!)
            
        
        }
        //
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
        
        return dictionary
    }
   
}
