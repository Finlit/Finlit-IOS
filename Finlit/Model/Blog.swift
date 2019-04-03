//
//  Blog.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 14/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import Foundation


public class Blog {
    public var id : String?
    public var title : String?
    public var description : String?
    public var imgUrl : String?
    public var likeCount : Int?
    public var commentCount : Int?
     public var isLike : Bool?
    public var user : User?
    public var link : String?
  
    
    
    public var tags : [NSDictionary]?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Blog_list = Blog.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Blog Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Blog]
    {
        var models:[Blog] = []
        for item in array
        {
            models.append(Blog(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Blog = Blog(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Blog Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        imgUrl = dictionary["imgUrl"] as? String
        title = dictionary["title"] as? String
        description = dictionary["description"] as? String
        likeCount = dictionary["likeCount"] as? Int
        commentCount = dictionary["commentCount"] as? Int
        isLike = dictionary["isLike"] as? Bool
        tags = dictionary["tags"] as? [NSDictionary]
        link = dictionary["link"] as? String
        
        if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as! NSDictionary) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.imgUrl, forKey: "imgUrl")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.likeCount, forKey: "likeCount")
        dictionary.setValue(self.commentCount, forKey: "commentCount")
        dictionary.setValue(self.isLike, forKey: "isLike")
        dictionary.setValue(self.tags, forKey: "tags")
        dictionary.setValue(self.link, forKey: "link")
        dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
        
        return dictionary
    }
    
}
