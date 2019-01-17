//
//  Interest.swift
//  Finlit
//
//  Created by Tech Farmerz on 07/12/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import Foundation

enum InterestModelAttributtes :String {
    case
    
    userId = "userId",
    name = "name"
    static let getAll = [
        
        userId,
        name
    ]
}
public class InterestModel {
    public var question : String?
    public var answer : String?
    public var isSelected : Bool?
   
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Post_list = Post.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Post Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [InterestModel]
    {
        var models:[InterestModel] = []
        for item in array
        {
            models.append(InterestModel(dictionary: item as! NSDictionary)!)
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
        question = dictionary["question"] as? String
        answer = dictionary["answer"] as? String
        isSelected = dictionary["isSelected"] as? Bool

//        if dictionary["user"] != nil{
//            let userid = dictionary["user"] as? NSDictionary
//            userId = userid!["id"] as? String
//            print(userId!)
//
//
//        }
        //
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        dictionary.setValue(self.question, forKey: "question")
        dictionary.setValue(self.answer, forKey: "answer")
        dictionary.setValue(self.isSelected, forKey: "isSelected")
        
        return dictionary
    }
    
}
