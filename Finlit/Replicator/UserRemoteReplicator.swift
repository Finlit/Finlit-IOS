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
        private let createfolder = "folders"
        private let createTask = "tasks"
        private let createCategory = "categories"
        private let amount = "amounts"
        private let todaystask = "tasks?sort=today"
        private let taskByFolderId =  "tasks?folderId="
        private let allTasks = "tasks"
        private let updateTaskStatus = "updateStatus/"
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
        

        
        //MARK:- Get State
        func getState(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
            
            let url = "states?countryId=" + "\(query)"
            
            
            let urlString =  "\(baseUrl1)\(url.html)"
            
            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
                callback(data, error)
            }
        }
        
        
        //MARK:- Get Towns of South Africa
        func getTowns(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
            
            let url = "zipCodes"
            
            
            let urlString =  "\(baseUrl1)\(url.html)"
            
            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
                callback(data, error)
            }
        }
        
        
        //MARK:- Get LGA by State ID
        func getLGAByStateId(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
            
            let url = "lgas?stateId=" + "\(query)"
            
            
            let urlString =  "\(baseUrl1)\(url.html)"
            
            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
                callback(data, error)
            }
        }
        
        
        
        //MARK:- Get LGA by Town ID
        func getLGAByTownId(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
            
            let url = "regions?zipCodeId=" + "\(query)"
            
            
            let urlString =  "\(baseUrl1)\(url.html)"
            
            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
                callback(data, error)
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
        //MARK:- Get User Details
      
        //        // MARK: createCategory
        //        func createCategory(categoryDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        //            let urlString =  "\(baseUrl1)\(createCategory.html)"
        //            remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: categoryDetials) { (data, error) -> Void in
        //                callback(data , error )
        //
        //            }
        //        }
        
        
        
        
        
//        // MARK: createFolder
//        func createFolder(folderDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//            let urlString =  "\(baseUrl1)\(createfolder.html)"
//            remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: folderDetials) { (data, error) -> Void in
//                callback(data , error )
//
//            }
//        }
//
//        //MARK:- Get All Folder
//        func getAllFolder(query:String = "" ,pageNo:Int = 1 ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
//
//            let url = "folders"
//
//
//            let urlString =  "\(baseUrl1)\(url.html)"
//
//            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
//                callback(data, error)
//            }
//        }
//
//
//        // MARK: createTask
//        func createTask(taskDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//            let urlString =  "\(baseUrl1)\(createTask.html)"
//            remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: taskDetials) { (data, error) -> Void in
//                callback(data , error )
//
//            }
//        }
//
//
//
//        //MARK:- Get Todays Task
//        func getTodaysTask(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
//            let url = todaystask
//
//            let urlString =  "\(baseUrl1)\(url.html)"
//
//            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
//                callback(data, error)
//            }
//        }
//
//
//        //MARK:- Get Task By Folder Id
//        func getTasksByFolderId(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
//            let url = taskByFolderId + "\(query)"
//
//            let urlString =  "\(baseUrl1)\(url.html)"
//
//            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
//                callback(data, error)
//            }
//        }
//
//
//        //MARK:- Get All Tasks
//        func getAllTasks(query:String = "" ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
//            let url = allTasks
//
//            let urlString =  "\(baseUrl1)\(url.html)"
//
//            remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
//                callback(data, error)
//            }
//        }
//
//
//
//        // MARK: updateTaskStatus
//        func updateTaskStatus(taskId:String,routeID:String?, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//            let urlString =  "\(baseUrl1)\(updateTaskStatus.html)\(taskId)"
//            var dict = ["status":"completed"]
//            if routeID != nil {
//                dict["routeID"] = routeID!
//            }
//
//            remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: dict as Dictionary<String, AnyObject>) { (data, error) -> Void in
//                callback(data , error )
//
//            }
//        }
//
//
//        // MARK: SpentAmount
//        func createAmount(amountDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
//            let urlString =  "\(baseUrl1)\(amount.html)"
//            remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: amountDetials) { (data, error) -> Void in
//                callback(data , error )
//
//            }
//        }
        
        
        //
        //    //MARK: Resend Code
        //    func resendVarificationCode(userDetials: Dictionary<String, String>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void) {
        //        let url =  "\(baseUrl1)\(resendCode.html)"
        //        remoteRepo.remotePOSTServiceWithParameters(urlString: url, params: userDetials as Dictionary<String, AnyObject>) { (data, error) -> Void in
        //            callback(data , error )
        //        }
        //    }
        //
        //
        //
        //    // MARK: SignUp With Device Id
        //    func userSignUp(userDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        //        let url =  "\(baseUrl1)\(signUp.html)"
        //
        //        remoteRepo.remotePOSTServiceWithParameters(urlString: url, params: userDetials) { (data, error) -> Void in
        //            callback(data , error )
        //
        //        }
        //    }
        //
        //
        //
        //
        //
        //    //MARK: Logout User
        //    func logoutUserWithCompletion(callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        //            let logout : String = self.logout
        //        remoteRepo.remotePOSTServiceWithParameters(urlString: logout, params: [:]) { (data, error) -> Void in
        //            callback(data , error )
        //        }
        //
        //    }
        //
        //    //MARK: Report a bug on Contact us
        //
        //    func reportBug(detail:Dictionary<String,AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        //        let url = "\(baseUrl2)\(reportBug)"
        //        remoteRepo.remotePOSTServiceWithParameters(urlString: url, params: detail) { (data, error) -> Void in
        //            callback(data , error )
        //        }
        //
        //    }
        
        
        
    }
    
    


