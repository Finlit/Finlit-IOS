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
    private let availableUsers = "users?filter="
    private let pendingUsers = "users/pending"
    private let confirmedUsers = "users/confirmed"
    private let verify = "users/verify"
    private let sendDateRequest = "users/userpending/"
    private let sendNoThanksRequestToAvailableUser = "users/userintrested/"
    private let create = "users/" //create/addprofile
    
    

    
    private let baseUrl1 = remoteConfig.mBaseUrl
    private var remoteRepo:RemoteRepository!
    
    init(){
        self.remoteRepo = RemoteRepository()
    }
    
    
    
    //MARK:- Get User Details
    func getAllAvailableUsers(type:String = "",callback:@escaping (_ responseData: Dictionary<String, AnyObject>?, _ error: NSError?) -> Void ) {
        
        let url = self.availableUsers
        
        
        let urlString =  "\(baseUrl1)\(url.html)" + type
        
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
    
    
    
}
