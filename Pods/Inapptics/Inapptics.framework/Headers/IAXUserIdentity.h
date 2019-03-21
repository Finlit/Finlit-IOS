//
// Created by Arpy Vanyan on 7/10/17.
// Copyright (c) 2017 Inapptics Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAXUserIdentity : NSObject

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *identity;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *name;
@property (nonatomic) NSNumber *gender;
@property (nonatomic) NSNumber *age;
@property (nonatomic) NSMutableDictionary *properties;

+ (instancetype)sharedInstance;

/*!
 @brief Save updated stored user data in user defaults
 */
- (void)update;

/*!
 * @brief Sets custom properties on user object
 * @description Use this method to associate custom key/value properties to the device user.
 *
 @b Swift Example:
 @code
 Inapptics.user().set(["fullName": "John Doe"]);
 @endcode
 
 @b Objective-C Example:
 @code
 [Inapptics.user set:@{@"fullName": @"John Doe"}];
 @endcode
 * @param properties Dictionary with key/values pairs to set on the user
 */
- (void)set:(NSDictionary *)properties;

/*!
 * @brief Unsets custom properties from user object
 * @description Use this method to remove associated custom key/value properties from the device user.
 *
 @b Swift Example:
 @code
 Inapptics.user().unset(["fullName"]);
 @endcode
 
 @b Objective-C Example:
 @code
 [Inapptics.user unset:@[@"fullName"]];
 @endcode
 * @param keys Array with keys to unset from the user
 */
- (void)unset:(NSArray *)keys;

/*!
 * @brief Unsets user identity
 * @description Use this method to remove user identity.
 *
 @b Swift Example:
 @code
 Inapptics.user().unset();
 @endcode
 
 @b Objective-C Example:
 @code
 [Inapptics.user unset];
 @endcode
 */
- (void)unset;

/*!
 * @brief Get saved user identity as a dictionary
 * @description Use this method on Inapptics.user to get currently saved user properties as a dictionary
 *
 * @return The user identity dictionary
 */
- (NSDictionary *)identityDict;

@end
