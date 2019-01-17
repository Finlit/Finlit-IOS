//
//  Options.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 01/11/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import Foundation


enum OptionsAttributes :String {
    
    
    case id = "id"
    case text = "text"
    case isCorrect = "isCorrect"
    
    
    static let getAll = [
        id,
        text,
        isCorrect
        
    ]
}


public class Options {
    public var id : String?
    public var text: String?
    public var isCorrect: Int?
    
    
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Options]
    {
        var models:[Options] = []
        for item in array
        {
            models.append(Options(dictionary: item as! NSDictionary)!)
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
        
        id = dictionary["id"] as? String
        text = dictionary["text"] as? String
        isCorrect = dictionary["isCorrect"] as? Int
    
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.text, forKey: "text")
        dictionary.setValue(self.isCorrect, forKey: "isCorrect")
        return dictionary
    }
    
}
