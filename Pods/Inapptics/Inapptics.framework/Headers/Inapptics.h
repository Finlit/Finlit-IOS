//
//  Inapptics.h
//  Inapptics
//
//  Created by Ashot Tonoyan on 4/20/16.
//  Copyright © 2016 Inapptics Inc. All rights reserved.
//

@import UIKit;

#import "IAXUserIdentifyKeys.h"
#import "IAXUserIdentity.h"

@class IAXUserIdentity;

//! Project version number for Inapptics.
FOUNDATION_EXPORT double InappticsVersionNumber;

//! Project version string for Inapptics.
FOUNDATION_EXPORT const unsigned char InappticsVersionString[];

@interface Inapptics : NSObject

+ (IAXUserIdentity *_Nonnull)user;

/*!
 
 @brief The default method for initializing Inapptics SDK.
 
 @description Call this method as the last line in @c application:didFinishLaunchingWithOptions: method of your @b AppDelegate file to initialize and enable the Inapptics SDK with @b default settings.

 @param appToken Get your App Token by navigating to [App settings] at https://app.inapptics.com if you don't have it yet.
 
 @note Crash reporting is enabled by default.
 
 @b Swift Example:
 @code
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 
    Inapptics.letsGo(withAppToken: "YOUR_APP_TOKEN")
    
    ...
 
    return true
}
 @endcode
 
 
 @b Objective-C Example:
 @code
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Inapptics letsGoWithAppToken:@"YOUR_APP_TOKEN"];
 
    ...
 
    return YES;
}
 @endcode
 
 */
+ (void)letsGoWithAppToken:(NSString *_Nonnull)appToken;

/*!
 
 @brief The method for initializing Inapptics SDK with the option to disable crash reporting.
 
 @description Call this method as the last line in @c application:didFinishLaunchingWithOptions: method of your @b AppDelegate file to initialize and enable the Inapptics SDK with the option to disable crash reporting.
 
 @param appToken Get your App Token by navigating to [App settings] at https://app.inapptics.com if you don't have it yet.
 @param crashReportingEnabled Crash reporting enabled
 
 @b Swift Example:
 @code
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    Inapptics.letsGo(withAppToken: "YOUR_APP_TOKEN", crashReportingEnabled: false)
 
    ...
 
    return true
}
 @endcode
 
 @b Objective-C Example:
 @code
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Inapptics letsGoWithAppToken:@"YOUR_APP_TOKEN" crashReportingEnabled:NO];
 
    ...
 
    return YES;
}
 @endcode
 
 */
+ (void)letsGoWithAppToken:(NSString *_Nonnull)appToken crashReportingEnabled:(BOOL)crashReportingEnabled;

/*!
 @brief This method identifies your user by allowing you to set your custom user ID, email and name for the user.
 
 @description This method can be called anytime @b after @b initializing @b Inapptics. If you set this multiple times during a session, the last set values will be preserved.
 
 @remark All subsequent sessions will automatically inherit the last set @b identity, unless @c +(void)unsetUserIdentity is explicitly called.
 
 @param identity Your custom ID of the user
 @param email User's email address
 @param name User's name
 
 @b Swift Example:
 @code
Inapptics.identifyUser(withId: "USER_ID", email: "EMAIL_ADDRESS", name: "USER_NAME")
 @endcode

 @b Objective-C Example:
 @code
[Inapptics identifyUserWithId:@"USER_ID" email:@"EMAIL_ADDRESS" name:@"USER_NAME"];
 @endcode
 */
+ (void)identifyUserWithId:(NSString *_Nonnull)identity email:(NSString *_Nonnull)email name:(NSString *_Nonnull)name;

/*!
 @brief Set your custom ID for the user.
 
 @description This method can be called anytime @b after @b initializing @b Inapptics. If you set this multiple times during a session, the last set values will be preserved.
 
 @remark All subsequent sessions will automatically inherit the last set @b identity, unless @c +(void)unsetUserIdentity is explicitly called.
 
 @param identity Your custom ID of the user
 
 @b Swift Example:
 @code
Inapptics.setUserId("USER_ID")
 @endcode

 @b Objective-C Example:
 @code
[Inapptics setUserId:@"USER_ID"];
 @endcode
 */
+ (void)setUserId:(NSString *_Nonnull)identity;

/*!
 @brief Set user's email address.
 
 @description This method can be called anytime @b after @b initializing @b Inapptics. If you set this multiple times during a session, the last set values will be preserved.
 
 @remark All subsequent sessions will automatically inherit the last set @b identity, unless @c +(void)unsetUserIdentity is explicitly called.
 
 @param email User's email address
 
 @b Swift Example:
 @code
Inapptics.setUserEmail("EMAIL_ADDRESS")
 @endcode

 @b Objective-C Example:
 @code
[Inapptics setUserEmail:@"EMAIL_ADDRESS"];
 @endcode
 */
+ (void)setUserEmail:(NSString *_Nonnull)email;

/*!
 @brief Set user's name.
 
 @description This method can be called anytime @b after @b initializing @b Inapptics. If you set this multiple times during a session, the last set values will be preserved.
 
 @remark All subsequent sessions will automatically inherit the last set @b identity, unless @c +(void)unsetUserIdentity is explicitly called.
 
 @param name User's name
 
 @b Swift Example:
 @code
Inapptics.setUserName("USER_NAME")
 @endcode

 @b Objective-C Example:
 @code
[Inapptics setUserName:@"USER_NAME"];
 @endcode
 */
+ (void)setUserName:(NSString *_Nonnull)name;

/*!
 @brief Set user's gender.
 
 @description This method can be called anytime @b after @b initializing @b Inapptics. If you set this multiple times during a session, the last set values will be preserved.
 
 @remark All subsequent sessions will automatically inherit the last set @b identity, unless @c +(void)unsetUserIdentity is explicitly called.
 
 @param gender User's gender
 
 @b Swift Example:
 @code
Inapptics.setUserGender(kIAXUserGenderFemale)
 @endcode

 @b Objective-C Example:
 @code
[Inapptics setUserGender:kIAXUserGenderFemale];
 @endcode
 */
+ (void)setUserGender:(NSInteger)gender;

/*!
 @brief Set user's age.
 
 @description This method can be called anytime @b after @b initializing @b Inapptics. If you set this multiple times during a session, the last set values will be preserved.
 
 @remark All subsequent sessions will automatically inherit the last set @b identity, unless @c +(void)unsetUserIdentity is explicitly called.
 
 @param age User's age
 
 @b Swift Example:
 @code
Inapptics.setUserAge(20)
 @endcode

 @b Objective-C Example:
 @code
[Inapptics setUserAge:20];
 @endcode
 */
+ (void)setUserAge:(NSInteger)age;

/*!
 @brief Unsets all previously set user identity parameters.
 
 @description This method can be used e.g. after a logout action, in order to avoid logged out users being tied to subsequent sessions.
 
 @remark Current session will still have the previously set identity, but subsequent sessions will not have an identity to inherit.
 
 @b Swift Example:
 @code
Inapptics.unsetUserIdentity()
 @endcode
 
 @b Objective-C Example:
 @code
[Inapptics unsetUserIdentity];
 @endcode
 */
+ (void)unsetUserIdentity;

/*!
 @brief This method is optional and can be used for tagging sessions.
 
 @description Optionally call this method in @c applicationDidBecomeActive: method of your @b AppDelegate file to tag a session. Tags can be used e.g. for A/B testing purposes.
 
 @note A single string tag with a maximum length of 128 charachters can be added to a session at a time.
 
 @param tag String tag (will be capped to 64 characters)
 
 @b Swift Example:
 @code
func applicationDidBecomeActive(_ application: UIApplication) {
    
    Inapptics.tagSession("Group A")
    
    ...
}
 @endcode
 
 @b Objective-C Example:
 @code
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [Inapptics tagSession:@"Group A"];
    
    ...
}
 @endcode
 
 */
+ (void)tagSession:(NSString *_Nonnull)tag;

#pragma mark Manual event trackers

/*!

 @brief This method is optional and can be used for tracking custom screens in sessions.

 @description Optionally call this method anywhere in your code to add a new screen to the ongoing session. It can be done when the SDK is unable to track custom view changes as a new screen view.

 @param screenName String the custom screen name (will be added to the screen as a title)

 @b Swift Example:
 @code
    Inapptics.addScreen("MyCustomAlert")
 @endcode

 @b Objective-C Example:
 @code
    [Inapptics addScreen:@"MyCustomAlert"];
 @endcode

 */
+ (void)addScreen:(NSString *_Nonnull)screenName;

/*!

 @brief This method should be used with custom screen addition in order to tell when the custom screen is exited.

 @description Call this method anywhere in your code after adding a custom screen to end its view and go the previous screen in the ongoing session.

 @b Swift Example:
 @code
    Inapptics.closeScreen()
 @endcode

 @b Objective-C Example:
 @code
    [Inapptics closeScreen];
 @endcode

 */
+ (void)closeScreen;

@end
