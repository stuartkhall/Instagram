//
//  InstagramClient.h
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//  Copyright (c) 2011 Bytesize. All rights reserved.
//

#import "AFHTTPClient.h"

@class InstagramUser;

@interface InstagramClient : AFHTTPClient

// Creates an autoreleased client with an auth token
+ (InstagramClient*)clientWithToken:(NSString*)token;

// Fetch a users details (can be 'self')
- (void)getUser:(NSString*)userId 
        success:(void (^)(InstagramUser* user))success
        failure:(void (^)(NSError* error, NSInteger statusCode))failure;

// Searches for users
- (void)searchUsers:(NSString*)query 
              limit:(int)count
            success:(void (^)(NSArray* users))success
            failure:(void (^)(NSError* error, NSInteger statusCode))failure;

// Get the current users feed
- (void)getFeed:(int)count 
          minId:(int)minId
          maxId:(int)maxId
            success:(void (^)(NSArray* media))success
            failure:(void (^)(NSError* error, NSInteger statusCode))failure;


@end
