//
//  DatesAPI.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 28/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import Foundation

class DatesAPI{
    
    private let DatesRemoteReplicatorr: DatesRemoteReplicator!
    
    
    //Utilize Singleton pattern by instanciating QuestionAPI only once.
    class var sharedInstance: DatesAPI {
        struct Singleton {
            static let instance = DatesAPI()
        }
        return Singleton.instance
    }
    
    init(){
        self.DatesRemoteReplicatorr = DatesRemoteReplicator()
        
    }
    
    
    // MARK:-- getAllUsers
    func getAllAvailableUsers(type:String,callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        DatesRemoteReplicatorr.getAllAvailableUsers(type: type, callback:  { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        })
    }
    
    
    
}

