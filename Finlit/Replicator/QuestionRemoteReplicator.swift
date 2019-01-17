//
//  QuestionRemoteReplicator.swift
//  SearchApp
//
//  Created by dEEEP on 14/03/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//

import Foundation


class QuestionRemoteReplicator{
  
  //MARK:- API constants
  private let createPost = "posts"
    private let updatePost = "posts/"
    
    private let getPosts = "posts"
    private let deletePost = "posts/"
    private let createLike = "users/favourite"
    private let createDisLike = "users/unfavourite"
     private let createComments = "comments"
     private let deleteComment = "comments/"
    private let createSaved = "posts/saved/"
    private let createUnSaved = "posts/unsaved/"
  private let comments = "comments/post"
   private let likes = "favourites/post"
  private let ratings = "ratings/post"
    private let getAllComments = "comments?postId="
    private let getReactedUsers = "posts/likes"
    private let reportPost = "reports/post/"
     private let reportComment = "reports/postComment/"
     private let nearSearch = "users"
    //chats
    private let Chat = "chats"
    private let setZeroCounts = "chats/setZeroUnreadCount/"
    private let incUnreadCounts = "chats/incUnreadCount/"
    private let blockcht = "chats/block/"
    private let unblockcht = "chats/unblock/"
    
   //private let content = "commentContents"
  private let baseUrl1 = remoteConfig.mBaseUrl
  private var remoteRepo:RemoteRepository!
  
  init(){
    self.remoteRepo = RemoteRepository()
  }
  
  
  
    // MARK: create Post
    func createPost(postDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(createPost.html)"
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: postDetials) { (data, error) -> Void in
            callback(data , error )
            
        }
    }
    
    
    //MARK: Delete Comment
    func deletePost(PostID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(deletePost.html)" + PostID
        remoteRepo.remoteDELETEServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
   
    //MARK:- Get All Questions
    func getAllQuestions(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        
        var url = "questions" + "?\("pageSize")="
        
        if query != ""{
            url = url + query
        }
        
        
        let urlString =  "\(baseUrl1)\(url.html)"
        
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }
   //sukh
    //MARK:- Get Post By ID
    func getallSearchdetails(query:String = "" ,lat:String = "" ,long:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        let url = nearSearch + "?latitude=\(lat)" + "&longitude=\(long)" + "&range=\(query)"
        
        let urlString =  "\(baseUrl1)\(url.html)"
        print(urlString)
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }
    
    //MARK:- Get filter
    func getfilter(latitude:String =
        "",longitude:String = "",range:String = "",filterBy:String = "",ageMin:String = "",ageMax : String = "",callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        let url = "users?" + longitude + latitude + filterBy + range + ageMin + ageMax
        
        let urlString =  "\(baseUrl1)\(url.html)"
        print(urlString)
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }
    //MARK:- Get Users
    func getUsers(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        let url = nearSearch
        
        let urlString =  "\(baseUrl1)\(url.html)"
        print(urlString)
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }

    //MARK:- Get Post By ID
    func getPostDetailsByID(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        let url = getPosts + "/\(query)"
        
        let urlString =  "\(baseUrl1)\(url.html)"
        
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }
    
    
    //MARK:- Get Post Comments By ID
    func getPostCommentsByID(postId:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        let url = getAllComments
        
        let urlString =  "\(baseUrl1)\(url.html)" + postId
        
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }
    //MARK: fav post
    func favPost(postID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(createLike.html)/" + postID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    //MARK: Unfav post
    func UnfavPost(postID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(createDisLike.html)/" + postID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    //MARK:- Get chat list
    func getchatlist(callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        
        let url = "chats"
       
        let urlString =  "\(baseUrl1)\(url.html)"
        
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }
    // MARK: Chat list
    func Chatadd(postDetials: [String:Any], callback:@escaping (_ responsedata: Dictionary<String, Any>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(Chat.html)"
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: postDetials as Dictionary<String, Any> as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error )
            
        }
    }
    // MARK: setCountZero
    
    func setZeroCount(PostID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(setZeroCounts.html)" + PostID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    // MARK: setCountZero
    func incUnreadCount(PostID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(setZeroCounts.html)" + PostID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    // MARK: blockChat
    func blockChat(PostID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(blockcht.html)" + PostID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    // MARK: unblockChat
    func unblockChat(PostID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(unblockcht.html)" + PostID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
     //MARK: Like post
      func likePost(postID:String,postDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(createLike.html)" + postID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: postDetials) { (data, error) -> Void in
          callback(data , error?.description )
    
        }
      }
    
    
    
    //MARK: Dislke post
    func dislikePost(postID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(createDisLike.html)/" + postID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    
    
    //MARK: Create Comment
    func createComment(postID:String,commentDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(createComments.html)"
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
  
    //MARK: Delete Comment
    func deleteComment(commentID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(deleteComment.html)" + commentID
        remoteRepo.remoteDELETEServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    //MARK: Create Saved
    func createSaved(postID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(createSaved.html)" + postID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    //MARK: Create UnSaved
    func createUnSaved(postID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(createUnSaved.html)" + postID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    
    
    
    //MARK:- Get Reacted Users By ID
    func getReactedUsersByID(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        let url = getReactedUsers + "/\(query)"
        let urlString =  "\(baseUrl1)\(url.html)"
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }
    
    
    
    func getAllNotifications(callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        let url = "notifications"
        
        let urlString =  "\(baseUrl1)\(url.html)"
        
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }
    
    
    
    
    
    //MARK: Report post
    func reportPost(postID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(reportPost.html)" + postID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    
    
    //MARK: Report Comment
    func reportComment(commentID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(reportComment.html)" + commentID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    
    // MARK: Update Post
    func updatePost(postID:String,postDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(updatePost.html)" + postID
        remoteRepo.remotePUTServiceWithParameters(urlString: urlString, params: postDetials) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    func setCountZeroChat(postID:String,postDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(setZeroCounts.html)" + postID
        remoteRepo.remotePUTServiceWithParameters(urlString: urlString, params: postDetials) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
  
//  //MARK:- Get Post By ID
//  func getPostByID(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
//    let url = getPost + "/\(query)"
//
//    let urlString =  "\(baseUrl1)\(url.html)"
//
//    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
//      callback(data, error)
//    }
//  }
//  
//  
//  func getAllCommentsForPost(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
//    let url = comments + "?entityId=\(query)" + "&pageNo=" + "\(pageNo)"
//    
//    let urlString =  "\(baseUrl1)\(url.html)"
//    
//    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
//      callback(data, error)
//    }
//  }
//  
//  
//  func getCommentsCensored(callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
//    let url = content
//    
//    let urlString =  "\(baseUrl1)\(url.html)"
//    
//    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
//      callback(data, error)
//    }
//  }
//  
//  
//  // MARK: Post Comment
//  func createCommentInPost(commentDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//    let urlString =  "\(baseUrl1)\(comments.html)"
//   
//    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
//      callback(data , error )
//      
//    }
//  }
//  
//  
//  // MARK: like Dislike post
//  func likeDislikepost(commentDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//    let urlString =  "\(baseUrl1)\(likes.html)"
//    
//    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
//      callback(data , error )
//      
//    }
//  }
//  
//  // MARK: dislike post
//  func dislikepost(postID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//    let urlString =  "\(baseUrl1)\(likes.html)/" + postID
//    remoteRepo.remoteDELETEServiceWithParameters(urlString: urlString, params: [:] as Dictionary<String, AnyObject>) { (data, error) -> Void in
//      callback(data , error?.description )
//      
//    }
//  }
//  
//  
//  // MARK: rating post
//  func ratingpost(commentDetials: [String:String], callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//    let urlString =  "\(baseUrl1)\(ratings.html)"
//    
//    remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: commentDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
//      callback(data , error )
//      
//    }
//  }
  
  
  
  
  

  
  
  
}

