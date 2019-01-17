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
  
  
  
    
    // MARK: Create Post
    func createPost(postDetials: Post , callback:@escaping (_ isSuccess:Bool , _ responseData:  Dictionary<String, AnyObject>? , _ error: String? ) -> Void)   {
        
        
        QuestionRemoteReplicatorr.createPost(postDetials: postDetials.dictionaryRepresentation() as! Dictionary<String, AnyObject> ) { (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//                    let postData = responseData![APIConstants.post.rawValue] as! Dictionary<String, AnyObject>
//                    let postDataFolder = NSKeyedArchiver.archivedData(withRootObject: postData)
//                    Constants.kUserDefaults.set(postDataFolder, forKey: appConstants.post)
                    callback(true,responseData,nil)
                }else{
                    callback(false,responseData,responseData!["error"] as? String)
                }
            }
            
        }
        
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
    
    
    //MARK:-- Get Post By Id From Remote
    func getPostDetailsByID(postId:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getPostDetailsByID(query: postId) { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    //Sukhwinder
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

    //MARK: Create Comment
    func createComment(postID: String ,commentDetials: Comment, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.createComment(postID: postID,commentDetials:commentDetials.dictionaryRepresentation() as! Dictionary<String, AnyObject>){ (Data, error) -> Void in
            if Data != nil {
                if (Data![APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    
                    
                    callback(true,Data,nil)
                }else{
                    callback(false,Data,Data!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    //MARK: Delete Comment
    func deleteComment(commentID: String , callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.deleteComment(commentID: commentID){ (Data, error) -> Void in
            if Data != nil {
                if (Data![APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,Data,nil)
                }else{
                    callback(false,Data,Data!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    //MARK:-- Get Post comments By Id From Remote
    func getPostCommentsByID(postId:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getPostCommentsByID(postId: postId) { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    
    
     //MARK: LikePost
    func likePost(postID: String ,postDetials: Dictionary<String, AnyObject>, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.likePost(postID: postID,postDetials:postDetials){ (responseData, error) -> Void in
          if responseData != nil {
            if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
    
    
    
              callback(true,responseData,nil)
            }else{
              callback(false,responseData,responseData!["error"] as? String)
            }
          }
    
        }
    
      }
    
    
    //MARK: DisLikePost
    func dislikePost(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.dislikePost(postID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    
                    
                    callback(true,nil)
                    
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    //MARK: CreateSaved
    func createSaved(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.createSaved(postID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    
                    
                    callback(true,nil)
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
  
    
    
    //MARK: CreateUnSaved
    func createUnSaved(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.createUnSaved(postID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,nil)
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
            
        }
        
    }

    
    
    //MARK:-- Get Post By Id From Remote
    func getReactedUsersByID(postId:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        QuestionRemoteReplicatorr.getReactedUsersByID(query: postId) { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
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
    
    
    
    //MARK: Report Post
    func reportPost(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.reportPost(postID: postID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    
                    
                    callback(true,nil)
                    
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    //MARK: Report Comment
    func reportComment(commentID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
        QuestionRemoteReplicatorr.reportComment(commentID: commentID){ (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    
                    
                    callback(true,nil)
                    
                }else{
                    callback(false,responseData!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    
    
    // MARK: Update Post
    func updatePost(postid:String,postDetials: Post , callback:@escaping (_ isSuccess:Bool , _ responseData:  Dictionary<String, AnyObject>? , _ error: String? ) -> Void)   {
        
        
        QuestionRemoteReplicatorr.updatePost(postID: postid, postDetials: postDetials.dictionaryRepresentation() as! Dictionary<String, AnyObject> ) { (responseData, error) -> Void in
            if responseData != nil {
                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
               
                    callback(true,responseData,nil)
                }else{
                    callback(false,responseData,responseData!["error"] as? String)
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
  //MARK:-- Get get Comments Censored Words
//  func getCommentsCensored(callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
//  {
//    QuestionRemoteReplicator.getCommentsCensored() { (Data, error) in
//      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
//        callback(Data! , nil)
//      }
//      else{
//        print("Getting Error")
//
//      }
//
//    }
//  }
//
//  //MARK:-- Get Post By Id From Remote
//  func getPostByID(Id:String, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
//  {
//    QuestionRemoteReplicator.getPostByID(query: Id) { (Data, error) in
//      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
//        callback(Data! , nil)
//      }
//      else{
//        print("Getting Error")
//
//      }
//
//    }
//  }
  
//
//  //MARK:-- Get Posts From Remote
//  func getAllCommentsForPost(id:String,pageNo:Int, callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
//  {
//    QuestionRemoteReplicator.getAllCommentsForPost(query: id,pageNo: pageNo) { (Data, error) in
//      if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
//        callback(Data! , nil)
//      }
//      else{
//        print("Getting Error")
//
//      }
//
//    }
//  }
  
  
//  // MARK: Add Comment
//  func postComment(commentDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ responseData:  Comment? , _ error: String? ) -> Void)   {
//    QuestionRemoteReplicator.createCommentInPost(commentDetials: commentDetials){ (responseData, error) -> Void in
//      if responseData != nil {
//        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//
//          let comment = Comment.init(dictionary: data as NSDictionary)
//          callback(true,comment,nil)
//        }else{
//          callback(false,nil,responseData!["error"] as? String)
//        }
//      }
//
//    }
//
//  }
//
//
//  // MARK: likeUnlikePost
//  func likeDislikepost(postDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
//    QuestionRemoteReplicator.likeDislikepost(commentDetials: postDetials){ (responseData, error) -> Void in
//      if responseData != nil {
//        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//
//
//          callback(true,nil)
//        }else{
//          callback(false,responseData!["error"] as? String)
//        }
//      }
//
//    }
//
//  }
//
//  // MARK: dislikePost
//  func dislikepost(postID: String , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
//    QuestionRemoteReplicator.dislikepost(postID: postID){ (responseData, error) -> Void in
//      if responseData != nil {
//        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//
//
//
//          callback(true,nil)
//        }else{
//          callback(false,responseData!["error"] as? String)
//        }
//      }
//
//    }
//
//  }
//
//
//  // MARK: RATINGPost
//  func ratingpost(postDetials: [String:String] , callback:@escaping (_ isSuccess:Bool , _ error: String? ) -> Void)   {
//    QuestionRemoteReplicator.ratingpost(commentDetials: postDetials){ (responseData, error) -> Void in
//      if responseData != nil {
//        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//          callback(true,nil)
//        }else{
//          callback(false,responseData!["error"] as? String)
//        }
//      }
//
//    }
//
//  }
  
  
  
//
//  // MARK: SignIn
//  func userSignIn(userDetials: Dictionary<String, AnyObject> , callback:@escaping (_ isSuccess:Bool , _ responseData:  Dictionary<String, AnyObject>? , _ error: String? ) -> Void)   {
//    userRemoteReplicator.userSignIn(userDetials: userDetials){ (responseData, error) -> Void in
//      if responseData != nil {
//        if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
//          let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
//          Constants.kUserDefaults.set(data[appConstants.id] , forKey: appConstants.id)
//          Constants.kUserDefaults.set(data[appConstants.token] , forKey: appConstants.token)
//          let dataProfile = NSKeyedArchiver.archivedData(withRootObject: data)
//          Constants.kUserDefaults.set(dataProfile, forKey: appConstants.profile)
//          Constants.kUserDefaults.set(data[UserAttributes.status.rawValue], forKey: UserAttributes.status.rawValue)
//
//
//
//          callback(true,responseData,nil)
//        }else{
//          callback(false,responseData,responseData!["error"] as? String)
//        }
//      }
//
//    }
//
//  }
//
  
  //    // MARK: Create User
  //    func userSignUp(userDetials: Dictionary<String, AnyObject> , callback:@escaping ( _ successResponse: Bool, _ error: String? ) -> Void)   {
  //
  //        userRemoteReplicator.userSignUp(userDetials: userDetials){ (responseData, error) -> Void in
  //            if responseData != nil{
  //                if (responseData?[APIConstants.isSuccess.rawValue] as? Bool)! == true{
  //
  //                    if let data = responseData?[APIConstants.data.rawValue]! as? Dictionary<String, AnyObject>!{
  //                        Constants.kUserDefaults.setValue(data["id"], forKey: appConstants.id)
  //                    }
  //                    callback(true,nil)
  //                }else{
  //                    print(responseData!["error"]!)
  //                    callback(false,responseData!["error"] as? String)
  //                }
  //            }else{
  //                callback(false,responseData!["error"] as? String)
  //            }
  //
  //        }
  //
  //    }
  //
  //    // MARK: ValidatePin
  //    func userValidatePin(employeeId:NSNumber,userDetials: Dictionary<String, String> , callback:@escaping (_ successResponse: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
  //
  //        userRemoteReplicator.userVarificationCode(employeeId: employeeId,userDetials:userDetials as Dictionary<String, AnyObject>){ (responseData, error) -> Void in
  //
  //            if responseData != nil{
  //                if  responseData![APIConstants.isSuccess.rawValue] as! Bool == true{
  //                    let data = responseData![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
  //                    Constants.kUserDefaults.set(data["id"], forKey: appConstants.id)
  //                    Constants.kUserDefaults.set(data["token"], forKey: appConstants.token)
  //                   // self.userLocalReplicator.saveUserProfile(userProfileDict: data)
  //                    callback(responseData,nil)
  //                }else{
  //                    callback(responseData,responseData!["error"] as? String)
  //                }
  //            }else{
  //                callback([:],responseData!["error"] as? String)
  //            }
  //        }
  //
  //    }
  //
  //
  //    //MARK:- Resend Code
  //    func resendVarificationCode(userDetials: Dictionary<String, String>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void) {
  //        userRemoteReplicator.resendVarificationCode(userDetials: userDetials) { (responseData, error) in
  //            if responseData != nil{
  //                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
  //                    let data = responseData?[APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
  //                    Constants.kUserDefaults.set(data["id"]!,forKey: appConstants.id)
  //                    print(Constants.kUserDefaults.value(forKey: "id")!)
  //                    callback(responseData , nil)
  //                }
  //                else{
  //                    callback(responseData, responseData!["error"] as? String)
  //                }
  //            }
  //        }
  //    }
  //
  //
  //
  //    //MARK:- Update User Password
  //
  //    func updateUserPassword(employeeId:NSNumber,userDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
  //        userRemoteReplicator.updateUserPassword(employeeId: employeeId, userDetials: userDetials) { (responseData, error) in
  //            if responseData != nil{
  //                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
  //                   // let data = responseData?[APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
  //
  //                    callback(responseData , nil)
  //                }
  //                else{
  //                    callback(responseData, responseData!["error"] as? String)
  //                }
  //            }
  //
  //        }
  //    }
  //    //MARK:- Report a bug
  //
  //    func reportBug(detail:Dictionary<String,AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
  //        userRemoteReplicator.reportBug(detail:detail) { (responseData, error) in
  //            if responseData != nil{
  //                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
  //                    // let data = responseData?[APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
  //
  //                    callback(responseData , nil)
  //                }
  //                else{
  //                    callback(responseData, responseData!["error"] as? String)
  //                }
  //            }
  //
  //        }
  //
  //    }
  //
  //
  //  //MARK:- UserManualCheckIn/CheckOut
  //  func userManualAttendence(detail:Dictionary<String,Any>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
  //    userRemoteReplicator.manualCheckInCheckOut(details:detail) { (responseData, error) in
  //      if responseData != nil{
  //        if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
  //          // let data = responseData?[APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
  //          callback(responseData , nil)
  //        }
  //        else{
  //          callback(responseData, responseData!["error"] as? String)
  //        }
  //      }
  //
  //    }
  //
  //  }
  //
  //
  //
  //    //MARK:- Getting External token for AMS
  //
  //    func getExternalToken(callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
  //        userRemoteReplicator.getExternalToken { (responseData, error ) in
  //            if responseData != nil{
  //                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
  //                    let data = responseData?["data"]
  //                    Constants.kUserDefaults.set(data?["token"]!, forKey: appConstants.token)
  //                    Constants.kUserDefaults.set(data?["id"]!, forKey: appConstants.id)
  //                    Constants.kUserDefaults.setValue(true, forKey: appConstants.alreadyLoggedIn)
  //                    let empty = NSNull()
  //                    if let name = data?["name"] as? String, !name.isEqual(empty), name != ""  {
  //                        Constants.kUserDefaults.set(name , forKey: "name")
  //
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "name")
  //
  //                    }
  //                    if let designation = data?["designation"] as? String, !designation.isEqual(empty) , designation != "" {
  //                        Constants.kUserDefaults.set(designation , forKey: "designation")
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "designation")
  //
  //                    }
  //                    if let picUrls = data?["picUrls"] as? String, !picUrls.isEqual(empty), picUrls != ""  {
  //                        Constants.kUserDefaults.set(picUrls as String, forKey: "picUrls")
  //                    }
  //                    if let email = data?["email"] as? String, !email.isEqual(empty) , email != "" {
  //                        Constants.kUserDefaults.set(email as String, forKey: "email")
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "email")
  //
  //                    }
  //                    if let phone = data?["phone"] as? String, !phone.isEqual(empty) , phone != "" {
  //                        Constants.kUserDefaults.set(phone as String, forKey: "phone")
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "phone")
  //
  //                    }
  //                    if let code = data?["code"] as? String, !code.isEqual(empty) , code != "" {
  //                        Constants.kUserDefaults.set(code as String, forKey: "code")
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "code")
  //
  //                    }
  //
  //
  //                    callback(responseData , nil)
  //                }
  //                else{
  //                    callback(responseData, responseData!["error"] as? String)
  //                }
  //            }
  //
  //        }
  //
  //    }
  //
  //    //MARK:- Sign in with tunnel
  //    func signInWithTunnel(callback:@escaping(_ responsedata: Dictionary<String,AnyObject>?, _ error: String?) -> Void){
  //        let tokenValue = Constants.kUserDefaults.value(forKey: appConstants.orgToken)
  //        Constants.kUserDefaults.set(tokenValue, forKey: appConstants.loggedInExternalOrgToken)
  //        Constants.kUserDefaults.set(tokenValue, forKey: appConstants.token)
  //        userRemoteReplicator.signInWithTunnel { (responseData, error ) in
  //            if responseData != nil{
  //                if responseData![APIConstants.isSuccess.rawValue] as! Bool == true {
  //                    let data = responseData?["data"]
  //                    Constants.kUserDefaults.set(data?["token"]!, forKey: appConstants.token)
  //                    Constants.kUserDefaults.set(data?["id"]!, forKey: appConstants.id)
  //                    Constants.kUserDefaults.setValue(true, forKey: appConstants.alreadyLoggedIn)
  //                    let empty = NSNull()
  //                    if let name = data?["name"] as? String, !name.isEqual(empty), name != ""  {
  //                        Constants.kUserDefaults.set(name , forKey: "name")
  //
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "name")
  //
  //                    }
  //                    if let designation = data?["designation"] as? String, !designation.isEqual(empty) , designation != "" {
  //                        Constants.kUserDefaults.set(designation , forKey: "designation")
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "designation")
  //
  //                    }
  //                    if let picUrls = data?["picUrls"] as? String, !picUrls.isEqual(empty), picUrls != ""  {
  //                        Constants.kUserDefaults.set(picUrls as String, forKey: "picUrls")
  //                    }
  //                    if let email = data?["email"] as? String, !email.isEqual(empty) , email != "" {
  //                        Constants.kUserDefaults.set(email as String, forKey: "email")
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "email")
  //
  //                    }
  //                    if let phone = data?["phone"] as? String, !phone.isEqual(empty) , phone != "" {
  //                        Constants.kUserDefaults.set(phone as String, forKey: "phone")
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "phone")
  //
  //                    }
  //                    if let code = data?["code"] as? String, !code.isEqual(empty) , code != "" {
  //                        Constants.kUserDefaults.set(code as String, forKey: "code")
  //                    }else{
  //                        Constants.kUserDefaults.set("" , forKey: "code")
  //
  //                    }
  //
  //
  //                    callback(responseData , nil)
  //                }
  //                else{
  //                    callback(responseData, responseData!["error"] as? String)
  //                }
  //            }
  //
  //        }
  //
  //    }
  
  
  
  // MARK: Create userProfile
  
  /**
   Create user profile, and persist it to Datastore via Worker(minion),
   that synchronizes with Main context.
   
   - Parameter userProfileDetails: <Dictionary<String, AnyObject> A single Profile to be persisted to the Datastore.
   - Returns: Void
   */
  
  
  
  
  
  
}

