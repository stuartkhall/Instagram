//
//  InstagramClient.m
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
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

#pragma mark - Generic requests wrappers

- (void)getPath:(NSString*)path
     modelClass:(Class)modelClass
     parameters:(NSMutableDictionary*)parameters
     collection:(void (^)(NSArray* models))collection
         single:(void (^)(InstagramModel* models))single
        failure:(void (^)(NSError* error, NSInteger statusCode))failure {
    // Add our token to the parameters
    [parameters setObject:token forKey:@"access_token"];
    // Fire off the request
    [self getPath:path
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([operation hasAcceptableStatusCode]) {
                  // Success!
                  if (collection)
                      collection([modelClass modelsFromDictionaries:[responseObject objectForKey:@"data"]]);
                  else if (single)
                      single([modelClass modelWithDictionary:[responseObject objectForKey:@"data"]]);
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

#pragma mark - User methods

- (void)getUser:(NSString*)userId 
        success:(void (^)(InstagramUser* user))success
        failure:(void (^)(NSError* error, NSInteger statusCode))failure {
    // Fire the get request
    [self getPath:[NSString stringWithFormat:@"users/%@/", userId]
       modelClass:[InstagramUser class]
       parameters:[NSMutableDictionary dictionary]
       collection:nil
           single:(void (^)(InstagramModel* user))success
          failure:failure];
}

- (void)searchUsers:(NSString*)query 
              limit:(NSInteger)count
            success:(void (^)(NSArray* users))success
            failure:(void (^)(NSError* error, NSInteger statusCode))failure {
    // Fire the get request
    [self getPath:@"users/search"
       modelClass:[InstagramUser class]
       parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:query, @"q", [NSNumber numberWithInt:count], @"count", nil]
       collection:success
           single:nil
          failure:failure];
}

// Get the current users feed
- (void)getUserFeed:(NSInteger)count
              minId:(NSString *)minId // nil for start
              maxId:(NSString *)maxId // nil for no upper limit
            success:(void (^)(NSArray* media))success
            failure:(void (^)(NSError* error, NSInteger statusCode))failure {
    // Setup the parameters
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:count], @"count",  nil];
    if (minId) [parameters setObject:minId forKey:@"min_id"];
    if (maxId) [parameters setObject:maxId forKey:@"max_id"];
    
    // Fire the get request
    [self getPath:@"users/self/feed"
       modelClass:[InstagramMedia class]
       parameters:parameters
       collection:success
           single:nil
          failure:failure];
}

// Get a user's media
- (void)getUserMedia:(NSString*)userId // Can be 'self' for the current user
               count:(NSInteger)count
               minId:(NSString *)minId // nil for start
               maxId:(NSString *)maxId // nil for no upper limit
             success:(void (^)(NSArray* media))success
             failure:(void (^)(NSError* error, NSInteger statusCode))failure {
    // Setup the parameters
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:count], @"count",  nil];
    if (minId) [parameters setObject:minId forKey:@"min_id"];
    if (maxId) [parameters setObject:maxId forKey:@"max_id"];
    
    // Fire the get request
    [self getPath:[NSString stringWithFormat:@"users/%@/media/recent", userId]
       modelClass:[InstagramMedia class]
       parameters:parameters
       collection:success
           single:nil
          failure:failure];
}

// Get the current user's likes
- (void)getUserLikes:(NSInteger)count
               maxId:(NSString *)maxId // nil for no upper limit
             success:(void (^)(NSArray* media))success
             failure:(void (^)(NSError* error, NSInteger statusCode))failure {
    // Setup the parameters
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:count], @"count",  nil];
    if (maxId) [parameters setObject:maxId forKey:@"max_id"];
    
    // Fire the get request
    [self getPath:@"users/self/media/liked"
       modelClass:[InstagramMedia class]
       parameters:parameters
       collection:success
           single:nil
          failure:failure];
}
@end
