//
//  QuestionAPI.swift
//  SearchApp
//
//  Created by dEEEP on 14/03/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation

/**
 UserSignIn API contains the endpoints to Create/Read/Update Logged in UserProfiles.
 */

class QuestionAPI{
  
  private let QuestionRemoteReplicatorr: QuestionRemoteReplicator!
  
  
  //Utilize Singleton pattern by instanciating QuestionAPI only once.
  class var sharedInstance: QuestionAPI {
    struct Singleton {
      static let instance = QuestionAPI()
    }
    return Singleton.instance
  }
  
  init(){
    self.QuestionRemoteReplicatorr = QuestionRemoteReplicator()
    
  }
  
  
  

    
    //MARK: Delete Post
    func deletePost(postID: String , callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.deletePost(PostID: postID){ (Data, error) -> Void in
            if Data != nil {
                if (Data![APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,Data,nil)
                }else{
                    callback(false,Data,Data!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    
    //MARK:-- Get All Questions
    func getAllQuestions(name:String,pageNo:Int, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getAllQuestions(query: name,pageNo: pageNo) { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    

    

    //MARK: FavPost
    func favPost(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.favPost(postID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    
                    
                    callback(true,nil)
                    
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
    //MARK: UnFavPost
    func UnfavPost(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.UnfavPost(postID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    
                    
                    callback(true,nil)
                    
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
    //MARK:-- Get Chat list
    func getchatlist(callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getchatlist() { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        }
    }
    //MARK:- Chat
    func Chatadd(postDetials: [String:Any] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Dictionary<String, Any>? , _ error: String? ) -> Void)   {
        
        QuestionRemoteReplicatorr.Chatadd(postDetials: postDetials ) { (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,responseData,nil)
                }else{
                    callback(false,responseData,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
    //MARK:- Set zero count
    func setZeroCount(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.setZeroCount(PostID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,nil)
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
        }
    }
    
    //MARK:- Set zero count
    func incUnreadCount(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.setZeroCount(PostID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,nil)
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
        }
    }
    //MARK:- Block chat Api
    func blockChat(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.blockChat(PostID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,nil)
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
        }
    }
    //MARK:- UnBlock chat Api
    func unblockChat(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.unblockChat(PostID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,nil)
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
        }
    }

    
    
    

    
    
    //MARK:-- Get Notifications
    func getAllNotifications(callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getAllNotifications() { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    
    //MARK:-- Get All Blogs
    func getAllBlogs(name:String,pageNo:Int,callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getAllBlogs() { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    
    //MARK:-- Get Blog Details Id From Remote
    func getBlogDetailsById(blogId:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void ) {
        
        QuestionRemoteReplicatorr.getBlogsDetailsById(query: blogId) { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
                
            else {
                print("Getting Error")
            }
            
        }
        
    }
    
    
    //MARK:-- Get Blog comments By Id
    func getCommentsOfBlog(blogId:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getCommentsOfBlog(blogId: blogId) { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
        }
    }
    
    
    //MARK: Create Comment
    func createComment(blogID: String ,commentDetials: Comment, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.createComment(blogID: blogID,commentDetials:commentDetials.dictionaryRepresentation() as! Dictionary<String, AnyObject>){ (Data, error) -> Void in
            if Data != nil {
                if (Data![APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    
                    
                    callback(true,Data,nil)
                }else{
                    callback(false,Data,Data!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    

    
    
    
    func setCountZeroChat(postid:String,postDetials: Chat , callback:@escaping (_ isSuccess:Bool , _ responseData:  Dictionary<String, AnyObject>? , _ error: String? ) -> Void)   {
        
        
        QuestionRemoteReplicatorr.setCountZeroChat(postID: postid, postDetials: postDetials.dictionaryRepresentation() as! Dictionary<String, AnyObject> ) { (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,responseData,nil)
                }else{
                    callback(false,responseData,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
    //MARK:- Sukhwinder
    
    //MARK:-- Get Post By Id From Remote
    func getallSearchdetails(postId:String,lat:String,long:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getallSearchdetails (query: postId,lat:lat ,long:long) { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        }
    }
  
    //MARK:-- Filter
    func getfilter(latitude:String,longitude:String,range:String,filterBy:String,ageMin:String,ageMax : String , callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getfilter (latitude:latitude,longitude:longitude,range:range,filterBy:filterBy,ageMin:ageMin,ageMax : ageMax) { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    
    
    
    
    
    //MARK: LikeBlog
    func likeBlog(blogID: String, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.likeBlog(blogID: blogID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{

                    callback(true,responseData,nil)
                }else{
                    callback(false,responseData,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    //MARK:  DIsLikeBlog
    func dislikeBlog(blogID: String, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.dislikeBlog(blogID: blogID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,responseData,nil)
                }else{
                    callback(false,responseData,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
  
  
  
  
  
  
}

