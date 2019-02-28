/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Comment {
	public var id : String?
	public var text : String?
	public var createdAt : String?
    public var blogId : String?
	public var user : User?
    public var tags : [NSDictionary]?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let Comment_list = Comment.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Comment Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Comment]
    {
        var models:[Comment] = []
        for item in array
        {
            models.append(Comment(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let Comment = Comment(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Comment Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? String
        blogId = dictionary["blogId"] as? String
		text = dictionary["text"] as? String
		createdAt = dictionary["createdAt"] as? String
    tags = dictionary["tags"] as? [NSDictionary]

		if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.blogId, forKey: "blogId")
		dictionary.setValue(self.text, forKey: "text")
		dictionary.setValue(self.createdAt, forKey: "createdAt")
      dictionary.setValue(self.tags, forKey: "tags")
		dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")

		return dictionary
	}

}
