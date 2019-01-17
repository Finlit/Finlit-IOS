//
//  Media.swift
//  Pheemee
//
//  Created by Gurpreet Gulati on 07/09/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

enum MediaAttributes: String {
    
    case mediaType = "mediaType"
    case url = "url"
    case thumbnail = "thumbnail"
    
    
    
    static let getAll = [
        mediaType,
        url,
        thumbnail
        
    ]
    
}

public class Media {
    public var mediaType : String?
    public var url : String?
    public var thumbnail : UIImage?
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Media_list = Media.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Media Instances.
     */
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Media]
    {
        var models:[Media] = []
        for item in array
        {
            models.append(Media(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Media = Media(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Media Instance.
     */
    
    
    required public init?(dictionary: NSDictionary) {
        
        mediaType = dictionary["mediaType"] as? String
        url = dictionary["url"] as? String
        thumbnail = dictionary["thumbnail"] as? UIImage
        
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.mediaType, forKey: "mediaType")
        dictionary.setValue(self.url, forKey: "url")
        dictionary.setValue(self.thumbnail, forKey: "thumbnail")
        
        return dictionary
    }
    
}


