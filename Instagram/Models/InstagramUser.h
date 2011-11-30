//
//  InstagramUser.h
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//  Copyright (c) 2011 Bytesize. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramUser : NSObject

// Initialises an autoreleased user from a JSON dictionary
+ (InstagramUser*)userWithDictionary:(NSDictionary*)dict;

// Initialises an array of users from an a array of JSON dictionaries
+ (NSArray*)usersFromDictionaries:(NSArray*)dicts;

// Public properties
@property (readonly) NSString* identifier;
@property (readonly) NSString* fullname;
@property (readonly) NSString* username;
@property (readonly) NSString* bio;
@property (readonly) NSString* website;
@property (readonly) NSString* profilePictureUrl;
@property (readonly) NSInteger followedByCount;
@property (readonly) NSInteger followersCount;
@property (readonly) NSInteger mediaCount;

@end
