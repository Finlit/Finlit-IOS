

import Foundation
 


enum UserAttributes :String {
  
  case name = "name"
    case age = "age"
    case picUrl = "picUrl"
  case email = "email"
  case isProfileCompleted = "isProfileCompleted"
  case password = "password"
  case newPassword = "newPassword"
  case deviceId = "deviceId"
  case deviceType = "deviceType"
  case imgUrl = "imgUrl"
  case userName = "userName"
  case token = "token"
  case id = "id"
  case status = "status"
  case aboutUs = "aboutUs"
     case interest = "interest"
   case lastName = "lastName"
   case phone = "phone"
   case location = "location"
    case userlocation = "userlocation"
    case ageGroup = "ageGroup"
    case gender = "gender"
    case profileType = "profileType"
    case googleId = "googleId"
    case activationCode = "activationCode"
    case userId = "userId"

    case isSelected = "isSelected"
    case locationCoordinates = "locationCoordinates"
    case birthday = "birthday"
    case createdAt = "createdAt"
 
    
    case facebookId = "facebookId"
      case question = "question"
    
    case date = "date"


  


    
    
    
    
    
  
  static let getAll = [
    name,
    email,
    password,
    picUrl,
    isProfileCompleted,
    newPassword,
    deviceId,
    deviceType,
     imgUrl,
    userName,
    token,
    id,
    status,
    aboutUs,
    lastName,
    phone,
    location,
    ageGroup,
    gender,
    profileType,
    googleId,
    activationCode,
    userId,
     interest,
    isSelected,
    locationCoordinates,
    birthday,
    createdAt,
    facebookId,
    age,
    question,
    userlocation,
    date

    
    
  ]
}


public class User {
	public var name : String?
    public var picUrl : String?
    public var ageGroup : Int?
	public var email : String?
	public var password : String?
  public var newPassword : String?
     public var oldPassword : String?
  public var isProfileCompleted : Bool?
	public var deviceId : String?
	public var deviceType : String?
	public var imgUrl : String?
	public var userName : String?
  public var token : String?
  public var id : String?
  public var status : String?
    public var aboutUs : String?
    public var lastName : String?
    public var phone : String?
    public var location : Location?
     public var userlocation : Location?
    public var interest : [InterestModel]?
    public var address : String?
    public var isFavourite : Int?

    public var gender : String?
    public var profileType : String?
    public var googleId : String?
    public var activationCode : String?
    public var userId : String?
    public var isFamily : Bool?
    public var familyId : Int?
    public var isSelected : Bool?
    public var locationCoordinates : [String]?
    public var birthday : String?
    public var createdAt : String?
    public var facebookId : String?
    public var townId : String?
    public var role : String?
    public var stateId : String?
    public var regionId : String?
    public var town : String?
    public var lga : String?
    public var state : String?
    public var region : String?
    public var question : String?
    
    public var date : String?


/**
    Returns an array of models based on given dictionary.
    
    Sample usageGroup:
    let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of User Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [User]
    {
        var models:[User] = []
        for item in array
        {
            models.append(User(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usageGroup:
    let User = User(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: User Instance.
*/
	required public init?(dictionary: NSDictionary) {

		name = dictionary["name"] as? String
       ageGroup = dictionary["ageGroup"] as? Int
		email = dictionary["email"] as? String
        picUrl = dictionary["picUrl"] as? String
		password = dictionary["password"] as? String
		deviceId = dictionary["deviceId"] as? String
		deviceType = dictionary["deviceType"] as? String
		 imgUrl = dictionary["imgUrl"] as? String
    newPassword = dictionary["newPassword"] as? String
		userName = dictionary["userName"] as? String
    status = dictionary["status"] as? String
    token = dictionary["token"] as? String
    id = dictionary["id"] as? String
        aboutUs = dictionary["aboutUs"] as? String
        lastName = dictionary["lastName"] as? String
        phone = dictionary["phone"] as? String
        isFavourite = dictionary["isFavourite"] as? Int
       if (dictionary["location"] != nil) {
        location = Location(dictionary: dictionary["location"] as! NSDictionary)
        let locations = dictionary["location"] as! NSDictionary
        address = locations["address"] as? String
        }
     
        gender = dictionary["gender"] as? String
        profileType = dictionary["profileType"] as? String
        googleId = dictionary["googleId"] as? String
        activationCode = dictionary["activationCode"] as? String
        userId = dictionary["userId"] as? String
        isSelected = dictionary["isSelected"] as? Bool
        isProfileCompleted = dictionary["isProfileCompleted"] as? Bool
        locationCoordinates = dictionary["locationCoordinates"] as? [String]
        birthday = dictionary["birthday"] as? String
        createdAt = dictionary["createdAt"] as? String
         facebookId = dictionary["facebookId"] as? String
        
        date = dictionary["date"] as? String
        
         if (dictionary["interest"] != nil) { interest = InterestModel.modelsFromDictionaryArray(array: dictionary["interest"] as! NSArray) }
        
   
        role = dictionary["role"] as? String
        let questarr = dictionary["question"]as? NSArray
        if questarr?.count != 0{
        question = questarr?.object(at: 0) as? String
        }
        
//           if (dictionary["userlocation"] != nil) { userlocation = Location(dictionary: dictionary["userlocation"] as! NSDictionary) }
        
           if (dictionary["userlocation"] != nil) && !(dictionary["userlocation"] is NSNull) { userlocation = Location(dictionary: dictionary["userlocation"] as! NSDictionary) }
        
        
        
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
    dictionary.setValue(self.newPassword, forKey: "newPassword")
		dictionary.setValue(self.deviceId, forKey: "deviceId")
		dictionary.setValue(self.deviceType, forKey: "deviceType")
		dictionary.setValue(self.imgUrl, forKey: "imgUrl")
		dictionary.setValue(self.userName, forKey: "userName")
    dictionary.setValue(self.status, forKey: "status")
    dictionary.setValue(self.id, forKey: "id")
    dictionary.setValue(self.token, forKey: "token")
        dictionary.setValue(self.aboutUs, forKey: "aboutUs")
        dictionary.setValue(self.lastName, forKey: "lastName")
        dictionary.setValue(self.phone, forKey: "phone")
      dictionary.setValue(self.location?.dictionaryRepresentation(), forKey: "location")
        dictionary.setValue(self.ageGroup, forKey: "ageGroup")
        dictionary.setValue(self.gender, forKey: "gender")
        dictionary.setValue(self.profileType, forKey: "profileType")
        dictionary.setValue(self.googleId, forKey: "googleId")
        dictionary.setValue(self.activationCode, forKey: "activationCode")
        dictionary.setValue(self.userId, forKey: "userId")
       dictionary.setValue(self.oldPassword, forKey: "oldPassword")
        
        dictionary.setValue(self.isSelected, forKey: "isSelected")
        dictionary.setValue(self.locationCoordinates, forKey: "locationCoordinates")
        dictionary.setValue(self.birthday, forKey: "birthday")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.facebookId, forKey: "facebookId")
        dictionary.setValue(self.townId, forKey: "townId")
        dictionary.setValue(self.isProfileCompleted, forKey: "isProfileCompleted")
        dictionary.setValue(self.role, forKey: "role")
        dictionary.setValue(self.question, forKey: "question")
        dictionary.setValue(self.date, forKey: "date")
        
         dictionary.setValue(self.userlocation?.dictionaryRepresentation(), forKey: "userlocation")
        
        
        var arr = [NSDictionary]()
        if self.interest != nil{
            for item in self.interest!{
                arr.append(item.dictionaryRepresentation())
            }
            dictionary.setValue(arr, forKey: "interest")
            
        }
        
       
//        let interestArray = NSMutableArray()
//        for item in self.interest!{
//            interestArray.add(item.dictionaryRepresentation())
//        }
//        dictionary.setValue(interestArray, forKey: "interest")
        
        
        

		return dictionary
	}

}
