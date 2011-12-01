//
//  InstagramClient.h
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//

#import "AFHTTPClient.h"

@class InstagramUser;

@interface InstagramClient : AFHTTPClient

// Creates an autoreleased client with an auth token
// keep a copy of this for yourself
+ (InstagramClient*)clientWithToken:(NSString*)token;

// Fetch a users details
- (void)getUser:(NSString*)userId // Can be 'self' for the current user
        success:(void (^)(InstagramUser* user))success
        failure:(void (^)(NSError* error, NSInteger statusCode))failure;

// Searches for users
- (void)searchUsers:(NSString*)query // e.g. 'Bob'
              limit:(int)count
            success:(void (^)(NSArray* users))success
            failure:(void (^)(NSError* error, NSInteger statusCode))failure;

// Get the current user's feed
- (void)getUserFeed:(int)count 
              minId:(int)minId // -1 for start
              maxId:(int)maxId // -1 for no upper limit
                success:(void (^)(NSArray* media))success
                failure:(void (^)(NSError* error, NSInteger statusCode))failure;

// Get a user's media
- (void)getUserMedia:(NSString*)userId // Can be 'self' for the current user
               count:(int)count 
               minId:(int)minId // -1 for start
               maxId:(int)maxId // -1 for no upper limit
             success:(void (^)(NSArray* media))success
             failure:(void (^)(NSError* error, NSInteger statusCode))failure;

// Get the current user's likes
- (void)getUserLikes:(int)count 
              maxId:(int)maxId // -1 for no upper limit
            success:(void (^)(NSArray* media))success
            failure:(void (^)(NSError* error, NSInteger statusCode))failure;

@end
