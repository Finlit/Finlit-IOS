//
//  Questions.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 01/11/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import Foundation



enum QuestionsAttributes :String {
    
    
    case id = "id"
    case label = "label"
    case options = "options"
    
    
    static let getAll = [
        id,
        label,
        options
        
    ]
}


public class Questions {
    public var id : String?
    public var label: String?
    public var options: [Options]?
    public var QuestionArr : NSArray?
    public var QuestionCount : Int?
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Questions]
    {
        print(array)
        var models:[Questions] = []
//        for item in array
//        {
//            print(item)
//            models.append(Questions(dictionary: item as! NSDictionary)!)
//        }
        models.append(Questions(array1: array)!)
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let User = User(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: User Instance.
     */
    required public init?(array1: NSArray) {
        print(array1)
        QuestionArr = array1
        QuestionCount = array1.count
        
        //id = dictionary["id"] as? String
     //   label = dictionary["label"] as? String
        
        //        if (dictionary["options"] != nil) { options = Options.modelsFromDictionaryArray(array: dictionary["options"] as! NSArray) }
        //
        
        //options = dictionary["options"] as? [Options]
        
        
    }
    
    required public init?(dictionary: NSDictionary) {
        print(dictionary)
        id = dictionary["id"] as? String
        label = dictionary["label"] as? String
        
//        if (dictionary["options"] != nil) { options = Options.modelsFromDictionaryArray(array: dictionary["options"] as! NSArray) }
//
        
        //options = dictionary["options"] as? [Options]
        
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.label, forKey: "label")
        
        var arr = [NSDictionary]()
        if self.options != nil{
            for item in self.options!{
                arr.append(item.dictionaryRepresentation())
            }
            dictionary.setValue(arr, forKey: "options")
        
        
        //dictionary.setValue(self.options, forKey: "options")
      
    }
      return dictionary
    }
    
    
    
}
