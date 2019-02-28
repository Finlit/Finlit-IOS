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
    
    
    
}
