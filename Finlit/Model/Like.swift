//
//  Like.swift
//  Pheemee
//
//  Created by Gurpreet Gulati on 07/09/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

enum LikeAttributes: String {
    
    case id = "id"
    case type = "type"
    
    
    
    static let getAll = [
        id,
        type
        
    ]
    
}

public class Like {
    public var id : String?
    public var type : String?
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Like_list = Like.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Like Instances.
     */
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Like]
    {
        var models:[Like] = []
        for item in array
        {
            models.append(Like(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Like = Like(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Like Instance.
     */
    
    
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        type = dictionary["type"] as? String
        
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.type, forKey: "type")
        
        return dictionary
    }
    
}


