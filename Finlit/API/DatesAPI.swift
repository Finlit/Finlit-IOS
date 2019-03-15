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
    func getAllAvailableUsers(type:String,minAge:String,maxAge:String,callback:@escaping (_ responseData:Dictionary<String,AnyObject>,_ error:String?) -> Void )
    {
        DatesRemoteReplicatorr.getAllAvailableUsers(type: type, ageMinimum: minAge,ageMaximum: maxAge, callback:  { (Data, error) in
            if Data![APIConstants.isSuccess.rawValue] as! Bool == true {
                callback(Data! , nil)
            }
            else{
                print("Getting Error")
                
            }
            
        })
    }
    
    
    
    
    
    
    
    
    
    
    func sendDateRequest(toUserID: String ,dateDetials: User, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        DatesRemoteReplicatorr.sendDateRequest(toUserID: toUserID,dateDetials:dateDetials.dictionaryRepresentation() as! Dictionary<String, AnyObject>){ (Data, error) -> Void in
            if Data != nil {
                if (Data![APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    
                    
                    callback(true,Data,nil)
                }else{
                    callback(false,Data,Data!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    
    func sendNoThanksRequest(toUserID: String ,dateDetials: User, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        DatesRemoteReplicatorr.sendNoThanksRequest(toUserID: toUserID,dateDetials:dateDetials.dictionaryRepresentation() as! Dictionary<String, AnyObject>){ (Data, error) -> Void in
            if Data != nil {
                if (Data![APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,Data,nil)
                }else{
                    callback(false,Data,Data!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    func sendConfirmRequest(toUserID: String, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        DatesRemoteReplicatorr.sendConfirmRequest(toUserID: toUserID){ (Data, error) -> Void in
            if Data != nil {
                if (Data![APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,Data,nil)
                }else{
                    callback(false,Data,Data!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    func sendNoThanksRequestToPendingUser(toUserID: String, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        DatesRemoteReplicatorr.sendNoThanksRequestToPendingUser(toUserID: toUserID){ (Data, error) -> Void in
            if Data != nil {
                if (Data![APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,Data,nil)
                }else{
                    callback(false,Data,Data!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    func cancelDateRequest(toUserID: String, callback:@escaping (_ isSuccess:Bool,_ responseData:Dictionary<String,AnyObject>? , _ error: String? ) -> Void)   {
        DatesRemoteReplicatorr.cancelDateRequest(toUserID: toUserID){ (Data, error) -> Void in
            if Data != nil {
                if (Data![APIConstants.isSuccess.rawValue] as? Bool)! == true{
                    
                    callback(true,Data,nil)
                }else{
                    callback(false,Data,Data!["error"] as? String)
                }
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
} //CLASS CLOSED

