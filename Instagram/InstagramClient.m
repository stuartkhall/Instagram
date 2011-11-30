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
                  success([InstagramUser userWithDictionary:[responseObject objectForKey:@"data"]]);
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
                  success([InstagramUser usersFromDictionaries:[responseObject objectForKey:@"data"]]);
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
