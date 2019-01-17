/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */


enum PostAttributes :String {
  case
  type = "type",
  id = "id",
  postId = "postId",
    text = "text",
  name = "name",
  description = "description",

  musicUrl = "musicUrl",
  favouriteCount = "favouriteCount",
  likeCount = "likeCount",
    viewCount = "viewCount",
  commentCount = "commentCount",
    savedCount = "savedCount",
 
  createdAt = "createdAt",
  favourite = "favourite",
    status = "status",
    isSaved = "isSaved",
    user = "user",
    media = "media",
    like = "like"

    
  
  
  static let getAll = [
    id,
    type,
    postId,
    name,
    text,
    description,

    musicUrl,
    favouriteCount,
    likeCount,
    commentCount,
    viewCount,
    savedCount,
   
    createdAt,
    favourite,
    status,
    isSaved,
    user,
    media,
    like
  ]
}

public class Post {
    public var type : String?
	public var id : String?
	public var name : String?
    public var postId : String?
    public var text : String?
	public var description : String?

	public var musicUrl : String?
	public var favouriteCount : Int?
	public var likeCount : Int?
	public var commentCount : Int?
    public var viewCount : Int?
    public var savedCount : Int?
	
  public var createdAt : String?
    public var status : String?
  public var favourite : NSObject?
    public var isSaved : Bool?
    public var user : User?
    public var media : Media?
    public var like : Like?
  

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let Post_list = Post.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Post Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Post]
    {
        var models:[Post] = []
        for item in array
        {
            models.append(Post(dictionary: item as! NSDictionary)!)
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
        type = dictionary["type"] as? String
		id = dictionary["id"] as? String
		name = dictionary["name"] as? String
        postId = dictionary["postId"] as? String
        text = dictionary["text"] as? String
		description = dictionary["description"] as? String
	
		musicUrl = dictionary["musicUrl"] as? String
		favouriteCount = dictionary["favouriteCount"] as? Int
		likeCount = dictionary["likeCount"] as? Int
		commentCount = dictionary["commentCount"] as? Int
        viewCount = dictionary["viewCount"] as? Int
        savedCount = dictionary["savedCount"] as? Int
	
    createdAt = dictionary["createdAt"] as? String
        status = dictionary["status"] as? String
    favourite = dictionary["favourite"] as? NSObject
        isSaved = dictionary["isSaved"] as? Bool
         if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as! NSDictionary) }
         if (dictionary["media"] != nil) && !(dictionary["media"] is NSNull) { media = Media(dictionary: dictionary["media"] as! NSDictionary) }
    
         if (dictionary["like"] != nil) && !(dictionary["like"] is NSNull) {
       
            
            like = Like(dictionary: dictionary["like"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()
        dictionary.setValue(self.type, forKey: "type")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.description, forKey: "description")
		dictionary.setValue(self.musicUrl, forKey: "musicUrl")
		dictionary.setValue(self.favouriteCount, forKey: "favouriteCount")
		dictionary.setValue(self.likeCount, forKey: "likeCount")
		dictionary.setValue(self.commentCount, forKey: "commentCount")
        dictionary.setValue(self.viewCount, forKey: "viewCount")
        dictionary.setValue(self.savedCount, forKey: "savedCount")
	
     dictionary.setValue(self.createdAt, forKey:"createdAt")
     dictionary.setValue(self.favourite, forKey: "favourite")
        dictionary.setValue(self.postId, forKey: "postId")
        dictionary.setValue(self.text, forKey: "text")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.isSaved, forKey: "isSaved")
        dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
        dictionary.setValue(self.media?.dictionaryRepresentation(), forKey: "media")
        dictionary.setValue(self.like?.dictionaryRepresentation(), forKey: "like")
		return dictionary
	}

}
