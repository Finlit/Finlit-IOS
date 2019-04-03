//
//  AppDelegate.swift
//  Finlit
//
//  Created by Gurpreet Singh on 05/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import IQKeyboardManagerSwift
import Inapptics





struct DataNotif: Codable {
    var title: String?
    var body: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case body
    }
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {
    
    var window: UIWindow?
    var msg_body = ""
    var msg_title = ""
    static var originalAppDelegate : AppDelegate!
    let notificationBanner = CWStatusBarNotification()
    func sharedInstance() -> AppDelegate{
        
        return AppDelegate.originalAppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().shouldEstablishDirectChannel = true
        Messaging.messaging().delegate = self
        
        
       Inapptics.letsGo(withAppToken: "8043b4b04ace11e99b475b5aadde95e7")
       DeployGateSDK.sharedInstance()?.launchApplication(withAuthor: "phillengel", key: "faad34275b9f0c8066f63695acf1b36f179c3516")
        
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, err) in
                if err != nil {
                    //Something bad happend
                } else {
                    UNUserNotificationCenter.current().delegate = self
                    Messaging.messaging().delegate = self
                    
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        application.beginBackgroundTask(withName: "showNotification", expirationHandler: nil)
        application.registerForRemoteNotifications()
        
        GMSPlacesClient.provideAPIKey("AIzaSyBzAo5EcHgJKWfBhOS_mVjp16fJCqtEOWc")
        GMSServices.provideAPIKey("AIzaSyBzAo5EcHgJKWfBhOS_mVjp16fJCqtEOWc")
        
        AppDelegate.originalAppDelegate = self
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        /// Paypal Sandbox and Live account keys
        
        //TODO: - Enter your credentials
        PayPalMobile .initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AeCNZX7ZsluSNCkatwk7enJjuLLUwr3-CLBqGuf8yfCu_vNL-zAcEkbEgDHjDABqb_LCezMSVpKKSYJM",
                                                                PayPalEnvironmentSandbox: "admin-facilitator@handsonfeedback.com"])
        
        return true
        
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        Constants.kUserDefaults.set(token, forKey: appConstants.fcmToken)
        
    }
    
    
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                Constants.kUserDefaults.set(result.token, forKey: appConstants.fcmToken)
            }
        }
        Messaging.messaging().apnsToken = deviceToken as Data
        
        
    }
    private func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound,UNNotificationPresentationOptions.badge])
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications with error: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
  
        completionHandler(.newData)
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response:UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        print("Handle push from background or closed")
        // if you set a member variable in didReceiveRemoteNotification, you will know if this is from closed or background
        print("\(response.notification.request.content.userInfo)")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
        print("Received data message: \(remoteMessage.appData)")
        
        guard let data: [String: Any] = remoteMessage.appData as? [String: Any] else {
            return
        }
        
        print(data)
        
        let contentData = data["content"] as! String
        print(contentData)
        let titleData = data["title"] as! String
        print(titleData)
        createNotification(title: titleData, body: contentData)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
    
    
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if (window?.rootViewController as? HomeVC) != nil {
            
        }
        
        completionHandler(.newData)
        
    }
    
    
    
    func createNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
        
        content.sound = UNNotificationSound.default()
        content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        let request = UNNotificationRequest.init(identifier: "pushNotif", content: content, trigger: nil)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
        public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    
         //384995035393668-gulati  if url.scheme == "fb709576229406877" {
           
            
            if url.scheme == "fb384995035393668" {
                let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
                    application,
                    open: url,
                    sourceApplication: sourceApplication,
                    annotation: annotation)
    
                return  facebookDidHandle
            }
            
            else if url.scheme == "deploygate.394110d66736d9c95fd5a91e165512d5da7a32de" {
                
                DeployGateSDK.sharedInstance()?.handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
                
            }
    
    
            let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
                application,
                open: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    
            return  facebookDidHandle
    
        }
    
    
    
    
    //
    //    func application(_ application: UIApplication, open url:URL , Options: [UIApplicationOpenURLOptionsKey: Any]?) -> Bool
    //    {
    //        let handled = FBSDKApplicationDelegate.sharedInstance().application
    //        (app, open: url, sourceApplication: Options [UIApplicationOpenURLOptionsSource.ApplicationKey] as! String!, annotation: [UIApplicationOpenURLOptionsSource.AnnotationKey])
    //        // Add any custom logic here.
    //        return handled;
    //    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        //    connectToFCM()
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        //  Messaging.messaging().shouldEstablishDirectChannel = false
        //   print("Disconnect FCM")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    private func configProgressHUD(){
        
        //        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        //        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    func showNotification(text: String){
        let displayInterval =  max(CGFloat(text.length) * 0.04 + 0.5,0.5)
        self.notificationBanner.display( withMessage: text, forDuration: Double(displayInterval) )
    }
    
    func showNotificationforDuration(text: String ,duration: TimeInterval){
        self.notificationBanner.display(withMessage: text, forDuration : duration)
    }
    
    
}


