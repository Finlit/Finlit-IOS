//
//  constants.swift
//  
//
//  Created by Gurpreet Gulati on 16/08/18.
//

import Foundation

enum APIConstants :String {
    case
    isSuccess = "isSuccess",
    data = "data",
    items = "items",
    pageNo = "pageNo",
    total = "total",
    totalRecords = "totalRecords"
}

struct appConstants{
  static let selecttype = "selecttype"
  static let token = "token"
  static let fcmToken = "fcmToken"
  static let UserImage = "UserImage"
  static let password = "password"
  static let profile = "profile"
  static let orgToken = "orgToken"
  static let deviceId = "deviceId"
  static let id = "id"
  static let userId = "userId"
  static let alreadyLoggedIn = "alreadyLoggedIn"
  static let chatid = "chatid"
  static let picUrls = "picUrls"
  static let email = "email"
  static let phone = "phone"
  static let code = "code"
  static let profileData = "profileData"
  static let designation = "designation"
  static let name = "name"
  static let censoredList = "censoredList"
  static let deviceType = "deviceType"
  static let username = "username"
  static let folder = "folder"
  static let task = "task"
  static let region = "region"
  static let country = "country"
  static let dob = "dob"
  static let zipCode = "zipCode"
  static let lga = "lga"
  static let googleId = "googleId"
  static let facebookId = "facebookId"
  static let post = "post"
   static let isLoggedIn = "isLoggedIn"
  static let isCorrect = "isCorrect"
  static let totalQuestionCount = "totalQuestionCount"
     static let findMeADate  = "findMeADate"
    
}
struct AppConstants{
    static let genderArray = ["Male","Female","Other","None"]
    static let serviceTax :Float = 2
    static let surchargeTax :Float = 0
}

struct Constants {
    static let kUserDefaults = UserDefaults.standard
}
let kAppDelegate = AppDelegate().sharedInstance()
