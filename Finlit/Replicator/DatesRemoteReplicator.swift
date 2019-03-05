//
//  DatesRemoteReplicator.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 28/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import Foundation

class DatesRemoteReplicator{
    
    //MARK:- API constants
    private let getDatingUsers = "users?filter="
//    private let pendingUsers = "users/pending"
//    private let confirmedUsers = "users/confirmed"
    private let verify = "users/verify"
    private let sendDateRequest = "users/userpending/"
    private let sendNoThanksRequestToAvailableUser = "users/userintrested/"
    private let sendNoThanksRequestToPendingUser = "users/userthank/"
    private let sendConfirmRequest = "users/userconfirmed/"
    private let create = "users/" //create/addprofile
    private let cancelDate = "users/unconfirmed/"
    
    

    
    private let baseUrl1 = remoteConfig.mBaseUrl
    private var remoteRepo:RemoteRepository!
    
    init(){
        self.remoteRepo = RemoteRepository()
    }
    
    
    
    //MARK:- Get User Details
    func getAllAvailableUsers(type:String = "", ageMinimum:String ,ageMaximum:String ,callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        
        var url = self.getDatingUsers + type
        
        if ageMinimum != "" && ageMaximum != "" {
            url = url + ageMinimum + ageMaximum
        }
        
        let urlString =  "\(baseUrl1)\(url.html)"
        
        remoteRepo.remoteGETService(urlString: urlString) { (data, error) -> Void in
            callback(data, error)
        }
    }
    
    
    //MARK: Create Date Request
    func sendDateRequest(toUserID:String,dateDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(sendDateRequest.html)" + toUserID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: dateDetials) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    //MARK: Create No Thanks Request
    func sendNoThanksRequest(toUserID:String,dateDetials: Dictionary<String, AnyObject>, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(sendNoThanksRequestToAvailableUser.html)" + toUserID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: dateDetials) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    //MARK: Create No Thanks Request
    func sendConfirmRequest(toUserID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(sendConfirmRequest.html)" + toUserID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:]) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    //MARK: Create No Thanks Request
    func sendNoThanksRequestToPendingUser(toUserID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(sendNoThanksRequestToPendingUser.html)" + toUserID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:]) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    //MARK: Cancel Date Request
    func cancelDateRequest(toUserID:String, callback:@escaping (_ responsedata: Dictionary<String, AnyObject>?, _ error: String? ) -> Void)   {
        let urlString =  "\(baseUrl1)\(cancelDate.html)" + toUserID
        remoteRepo.remotePOSTServiceWithParameters(urlString: urlString, params: [:]) { (data, error) -> Void in
            callback(data , error?.description )
            
        }
    }
    
    
    
}
