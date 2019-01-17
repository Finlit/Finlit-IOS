//
//  SocialAcntDetails.swift
//  Pheemee
//
//  Created by Gurpreet Gulati on 17/08/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

enum SocialAcntDetailsAttributes :String {
    
    case name = "name"
    case email = "email"
    case password = "password"
    case newPassword = "newPassword"
    case deviceId = "deviceId"
    case deviceType = "deviceType"
    case picUrl = "picUrl"
    case username = "username"
    case token = "token"
    case id = "id"
    case status = "status"
    case firstName = "firstName"
    case lastName = "lastName"
    case phone = "phone"
    case location = "location"
    case age = "age"
    case gender = "gender"
    case registrationId = "registrationId"
    case googleId = "googleId"
    case activationCode = "activationCode"
    case userId = "userId"
    case isFamily = "isFamily"
    case familyId = "familyId"
    case isSelected = "isSelected"
    case locationCoordinates = "locationCoordinates"
    case picture = "picture"
    case birthday = "birthday"
    
    
    
    
    
    
    
    static let getAll = [
        name,
        email,
        password,
        newPassword,
        deviceId,
        deviceType,
        picUrl,
        username,
        token,
        id,
        status,
        firstName,
        lastName,
        phone,
        location,
        age,
        gender,
        registrationId,
        googleId,
        activationCode,
        userId,
        isFamily,
        familyId,
        isSelected,
        locationCoordinates,
        picture,
        birthday
        
    ]
}


public class SocialAcntDetails {
    public var name : String?
    public var email : String?
    public var password : String?
    public var newPassword : String?
    public var deviceId : String?
    public var deviceType : String?
    public var picUrl : String?
    public var username : String?
    public var token : String?
    public var id : String?
    public var status : String?
    public var firstName : String?
    public var lastName : String?
    public var phone : String?
    public var location : [String:String]?
    public var age : String?
    public var gender : String?
    public var registrationId : String?
    public var googleId : String?
    public var activationCode : String?
    public var userId : Int?
    public var isFamily : Bool?
    public var familyId : Int?
    public var isSelected : Bool?
    public var locationCoordinates : [String]?
    public var picture : [NSDictionary:NSDictionary]?
    public var birthday : String?
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [SocialAcntDetails]
    {
        var models:[SocialAcntDetails] = []
        for item in array
        {
            models.append(SocialAcntDetails(dictionary: item as! NSDictionary)!)
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
        email = dictionary["email"] as? String
        password = dictionary["password"] as? String
        deviceId = dictionary["deviceId"] as? String
        deviceType = dictionary["deviceType"] as? String
        picUrl = dictionary["picUrl"] as? String
        newPassword = dictionary["newPassword"] as? String
        username = dictionary["username"] as? String
        status = dictionary["status"] as? String
        token = dictionary["token"] as? String
        id = dictionary["id"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        phone = dictionary["phone"] as? String
        location = dictionary["location"] as? [String:String]
        age = dictionary["age"] as? String
        gender = dictionary["gender"] as? String
        registrationId = dictionary["registrationId"] as? String
        googleId = dictionary["googleId"] as? String
        activationCode = dictionary["activationCode"] as? String
        userId = dictionary["userId"] as? Int
        isFamily = dictionary["isFamily"] as? Bool
        familyId = dictionary["familyId"] as? Int
        isSelected = dictionary["isSelected"] as? Bool
        locationCoordinates = dictionary["locationCoordinates"] as? [String]
        picture = dictionary["picture"] as? [NSDictionary:NSDictionary]
        birthday = dictionary["birthday"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.password, forKey: "password")
        dictionary.setValue(self.password, forKey: "newPassword")
        dictionary.setValue(self.deviceId, forKey: "deviceId")
        dictionary.setValue(self.deviceType, forKey: "deviceType")
        dictionary.setValue(self.picUrl, forKey: "picUrl")
        dictionary.setValue(self.username, forKey: "username")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.token, forKey: "token")
        dictionary.setValue(self.firstName, forKey: "firstName")
        dictionary.setValue(self.lastName, forKey: "lastName")
        dictionary.setValue(self.phone, forKey: "phone")
        dictionary.setValue(self.location, forKey: "location")
        dictionary.setValue(self.age, forKey: "age")
        dictionary.setValue(self.gender, forKey: "gender")
        dictionary.setValue(self.registrationId, forKey: "registrationId")
        dictionary.setValue(self.googleId, forKey: "googleId")
        dictionary.setValue(self.activationCode, forKey: "activationCode")
        dictionary.setValue(self.userId, forKey: "userId")
        dictionary.setValue(self.isFamily, forKey: "isFamily")
        dictionary.setValue(self.familyId, forKey: "familyId")
        dictionary.setValue(self.isSelected, forKey: "isSelected")
        dictionary.setValue(self.locationCoordinates, forKey: "locationCoordinates")
        dictionary.setValue(self.picture, forKey: "picture")
        dictionary.setValue(self.birthday, forKey: "birthday")
        
        
        
        return dictionary
    }
    
}
