//
//  UserRemoteReplicator.swift
//  AQUA
//
//  Created by Krishna on 05/04/17.
//  Copyright © 2017 MindfulSas. All rights reserved.
//

import Foundation

    
    class UserRemoteReplicator{
        
        //MARK:- API constants
        private let signUp = "users/signup"
        private let signIn = "users/signin"
        private let update = "users/"
        private let verify = "users/verify"
        private let create = "users/" //create/addprofile
      
        private let createTask = "tasks"
        private let createCategory = "categories"

      
    
        private let forgotPassword = "users/forgetPassword"
        private let setZeroCounts = "chats/setZeroUnreadCount/"
        private let incUnreadCounts = "chats/incUnreadCount/"
        
        private let baseUrl1 = remoteConfig.mBaseUrl
        private var remoteRepo:RemoteRepository!
        
        init(){
            self.remoteRepo = RemoteRepository()
        }
        
        
        
        // MARK: SignIn With Email
        func userSignIn(userDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
            let urlString =  "\(baseUrl1)\(signIn.html)"
            remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: userDetials) { (data, error) -> Void in
                callback(data , error )
                
            }
        }
        
        //MARK: VarificationCode With Email
        func userVarificationCode(userDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
            
            let urlString =  "\(baseUrl1)\(verify.html)"
            
            remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: userDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
                callback(data , error )
            }
        }
        
        
        
        
        // MARK: SignUp With Email
        func userSignUp(userDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
            let urlString =  "\(baseUrl1)\(signUp.html)"
            remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: userDetials) { (data, error) -> Void in
                callback(data , error )
                
            }
        }
        
        
        // MARK: SignUp With Email
        func forgotPassword(userDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
            let urlString =  "\(baseUrl1)\(forgotPassword.html)"
            remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: userDetials) { (data, error) -> Void in
                callback(data , error )
                
            }
        }
        
        
        // MARK: Update Profile
        func userUpdateProfile(userDetials: Dictionary<String, AnyObject>,userID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
            let urlString =  "\(baseUrl1)\(create.html)" + userID
            remoteRepo.remotePUTServiceWithParameters(urlString: urlString, params: userDetials) { (data, error) -> Void in
//              if data != nil{
//                if data![APIConstants.data.rawValue] != nil{
//                  let profileData = NSKeyedArchiver.archivedData(withRootObject:data![APIConstants.data.rawValue])
//                  Constants.kUserDefaults.set(profileData, forKey: appConstants.profileData.rawValue)
//                }
//              }
              
              
              
                callback(data , error?.description )
              
              
                
            }
        }
        // MARK: Update Profile
        func setcount(userDetials: Dictionary<String, AnyObject>,userID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
            let urlString =  "\(baseUrl1)\(setZeroCounts.html)" + userID
            remoteRepo.remotePUTServiceWithParameters(urlString: urlString, params: userDetials) { (data, error) -> Void in
                //              if data != nil{
                //                if data![APIConstants.data.rawValue] != nil{
                //                  let profileData = NSKeyedArchiver.archivedData(withRootObject:data![APIConstants.data.rawValue])
                //                  Constants.kUserDefaults.set(profileData, forKey: appConstants.profileData.rawValue)
                //                }
                //              }
                
                
                
                callback(data , error?.description )
                
                
                
            }
        }
        // MARK: Update Profile
        func incUnreadCount(userDetials: Dictionary<String, AnyObject>,userID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
            let urlString =  "\(baseUrl1)\(incUnreadCounts.html)" + userID
            remoteRepo.remotePUTServiceWithParameters(urlString: urlString, params: userDetials) { (data, error) -> Void in
              
                callback(data , error?.description )

                
            }
        }
        
        
        // MARK: Update Profile userUpdateProfileWhenForgotPassword
        func userUpdateProfileWhenForgotPassword(userDetials: Dictionary<String, AnyObject>,userID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
            let urlString =  "\(baseUrl1)\(create.html)" + userID
            remoteRepo.remotePUTServiceWithParameters(urlString: urlString, params: userDetials) { (data, error) -> Void in
                callback(data , error?.description )
                
            }
        }
        

        
        
    
        
        //MARK:- Get User Details
                func getUserDetails(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        
                    let url = "users/" + "\(query)"
        
        
                    let urlString =  "\(baseUrl1)\(url.html)"
        
                    remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
                        callback(data, error)
                    }
                }
      
      
      
      //MARK:- Get User Details
        func getAllUsers(type:String = "",callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        
        let url = "users" + type
        
        
        let urlString =  "\(baseUrl1)\(url.html)"
        
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
          callback(data, error)
        }
      }
        
        
        
        
      
        //MARK:- Get User Details
        func getAllFavUsers(callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
            let url = "users?filter=favourite"
            let urlString =  "\(baseUrl1)\(url.html)"
            
            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
                callback(data, error)
            }
        }
        
        //MARK:- Get favSearch
        func favSearch(query:String = ""  ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
            
            let url = "users?filter=favourite&name=" + "\(query)"
            
            
            let urlString =  "\(baseUrl1)\(url.html)"
            
            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
                callback(data, error)
            }
        }
        
        //MARK:- Get favSearch
        func AllSearch(query:String = ""  ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
            
            let url = "users?name=" + "\(query)"
            
            
            let urlString =  "\(baseUrl1)\(url.html)"
            
            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
                callback(data, error)
            }
        }

        
        
    }
    
    


