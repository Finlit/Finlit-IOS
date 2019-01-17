//
//  Chat.swift
//  Finlit
//
//  Created by Tech Farmerz on 07/12/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import Foundation
enum ChatAttributes :String {
    case
    opponent = "opponent",
    chatType = "chatType",
    identity = "Identity",
    
    userId = "userId",
    name = "name"
    
    static let getAll = [
        
        opponent,
        chatType,
        identity,
        
        userId,
        name
    ]
}

public class Chat {
    public var chatType : String?
    public var identity : String?
    // public var opponent: OpponentModel?
    public var ChatID : String?
    
    // chat data
    public var chatId : String?
    public var message : String?
    public var msgId: String?
    public var timeStamp : Double?
    public var toUserId : String?
    
    public var name: String?
    public var id : String?
    //  public var ChatID : String?
    public var imgUrl : String?
    
    public var address: String?
    public var isFavourite : Int?
    public var isProfileCompleted : Int?
    public var lastMessage : String?
    
    public var unreadCount: Int?
    public var isBlocked: Int?
    public var isAdmin: Int?
    public var aboutUs : String?
    public var opponentId : String?
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Post_list = Post.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Post Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Chat]
    {
        var models:[Chat] = []
        for item in array
        {
            models.append(Chat(dictionary: item as! NSDictionary)!)
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
        //  ChatID = dictionary["id"] as? String
      if dictionary["user"] != nil{
        let user = dictionary["user"]as? NSDictionary
        name = user!["name"] as? String
        id = user!["id"] as? String
        imgUrl = user!["imgUrl"] as? String
        isProfileCompleted = user!["isProfileCompleted"] as? Int
         isFavourite = user!["isFavourite"] as? Int
        
        if user!["location"] != nil{
            let loc = user!["location"]as? NSDictionary
            address = loc!["address"]as?String
            
        }
        }
        // chat data
        chatId = dictionary["id"] as? String
        message = dictionary["message"] as? String
        msgId = dictionary["msgId"] as? String
        timeStamp = dictionary["timeStamp"] as? Double
        opponentId = dictionary["opponentId"] as? String
        
        isAdmin = dictionary["isAdmin"] as? Int
        isBlocked = dictionary["isBlocked"] as? Int
        unreadCount = dictionary["unreadCount"] as? Int
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary.setValue(self.chatType, forKey: "chatType")
        dictionary.setValue(self.identity, forKey: "identity")
        dictionary.setValue(self.lastMessage, forKey: "lastMessage")
        //     dictionary.setValue(self.opponent?.dictionaryRepresentation(), forKey: "opponent")
        
        return dictionary
    }
    
}
