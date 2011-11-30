//
//  InstagramClient.m
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//  Copyright (c) 2011 Bytesize. All rights reserved.
//

#import "InstagramClient.h"
#import "AFJSONRequestOperation.h"

#import "InstagramUser.h"
#import "InstagramMedia.h"

// Private
@interface InstagramClient()
@property (nonatomic, retain) NSString* token;
@end

@implementation InstagramClient

static NSString* const kInstagramApiUrl = @"https://api.instagram.com/v1/";

@synthesize token;

#pragma mark - Initialisation

+ (InstagramClient*)clientWithToken:(NSString*)t {
    InstagramClient* client = [[InstagramClient alloc] initWithBaseURL:[NSURL URLWithString:kInstagramApiUrl]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    client.token = t;
    return [client autorelease];
}

#pragma mark - Memory management

- (void)dealloc {
    self.token = nil;
    [super dealloc];
}

#pragma mark - User methods

- (void)getUser:(NSString*)userId 
        success:(void (^)(InstagramUser* user))success
        failure:(void (^)(NSError* error, NSInteger statusCode))failure {
    // Setup the parameters
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:token, @"access_token", nil];
    
    // Fire off the request
    [self getPath:[NSString stringWithFormat:@"users/%@/", userId]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([operation hasAcceptableStatusCode]) {
                  // Success!
                  success((InstagramUser*)[InstagramUser modelWithDictionary:[responseObject objectForKey:@"data"]]);
              }
              else {
                  // Positive failure
                  failure([NSError errorWithDomain:@"Instagram" code:0 userInfo:nil], [[operation response] statusCode]);
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              // Bombed
              failure(error, [[operation response] statusCode]);
          }
     ];
}

- (void)searchUsers:(NSString*)query 
              limit:(int)count
            success:(void (^)(NSArray* users))success
            failure:(void (^)(NSError* error, NSInteger statusCode))failure {
    // Setup the parameters
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:token, @"access_token", 
                                                                                        query, @"q", 
                                                                                        [NSNumber numberWithInt:count], @"count", 
                                                                                        nil];
    
    // Fire off the request
    [self getPath:@"users/search"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([operation hasAcceptableStatusCode]) {
                  // Success!
                  success([InstagramUser modelsFromDictionaries:[responseObject objectForKey:@"data"]]);
              }
              else {
                  // Positive failure
                  failure([NSError errorWithDomain:@"Instagram" code:0 userInfo:nil], [[operation response] statusCode]);
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              // Bombed
              failure(error, [[operation response] statusCode]);
          }
     ];
}

// Get the current users feed
- (void)getFeed:(int)count 
          minId:(int)minId
          maxId:(int)maxId
        success:(void (^)(NSArray* media))success
        failure:(void (^)(NSError* error, NSInteger statusCode))failure {
    // Setup the parameters
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:token, @"access_token", 
                                       [NSNumber numberWithInt:count], @"count", 
                                       nil];
    
    // Set the minumum ID if required
    if (minId > 0) {
        [parameters setObject:[NSNumber numberWithInt:minId] forKey:@"minId"];
    }
    
    // Set the maximum ID if required
    if (maxId > 0) {
        [parameters setObject:[NSNumber numberWithInt:maxId] forKey:@"maxId"];
    }
    
    // Fire off the request
    [self getPath:@"users/self/feed"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([operation hasAcceptableStatusCode]) {
                  success([InstagramMedia modelsFromDictionaries:[responseObject objectForKey:@"data"]]);
              }
              else {
                  // Positive failure
                  failure([NSError errorWithDomain:@"Instagram" code:0 userInfo:nil], [[operation response] statusCode]);
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              // Bombed
              failure(error, [[operation response] statusCode]);
          }
     ];

}
@end
