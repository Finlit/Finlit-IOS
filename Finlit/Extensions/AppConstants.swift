//
//  AppConstants.swift
//  Pheemee
//
//  Created by Gurpreet Gulati on 16/08/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation

import Foundation
struct Constants {
    static let kUserDefaults = UserDefaults.standard
}
let kAppDelegate = AppDelegate().sharedInstance()



//struct pheemeeConfig{
//    
//    static let mBaseUrl = "http://18.219.127.28:3030/api/"
//    static let environment = "PRO"
//    static let googleAPIKey = "AIzaSyD24CVsxirIYTY2uejIlhfrCMyBlPmJ2kc"
//    // static let environment = "DEBUG"
//    
//}

enum APIConstants :String {
    case
    isSuccess = "isSuccess",
    data = "data",
    items = "items",
    pageNo = "pageNo",
    total = "total",
    totalRecords = "totalRecords",
    pageSize = "pageSize",
    post = "post"

}

struct cloudinaryConfig {
    static let cloud_name = "do88olltv"
    static let api_key = "671911767542257"
    static let api_secret = "TxO4rzOQMrl4Ibp1ueY-7pfTFuw"
}




struct appConstants{
    static let token = "token"
    static let password = "password"
    static let profile = "profile"
    static let orgToken = "orgToken"
    static let deviceId = "deviceId"
    static let id = "id"
    static let userId = "userId"
    static let alreadyLoggedIn = "alreadyLoggedIn"
    static let picUrls = "picUrls"
    static let email = "email"
    static let phone = "phone"
    static let code = "code"
    static let profileData = "profileData"
    static let designation = "designation"
    static let name = "name"
    static let censoredList = "censoredList"
    static let deviceType = "deviceType"
    static let userName = "userName"
    static let folder = "folder"
    static let task = "task"
    static let region = "region"
    static let country = "country"
    static let age = "age"
    static let town = "town"
    static let lga = "lga"
    static let googleId = "googleId"
    static let facebookId = "facebookId"
    static let post = "post"
}
struct AppConstants{
    static let genderArray = ["Male","Female","Other","None"]
}


