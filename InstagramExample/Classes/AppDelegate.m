//
//  AppDelegate.m
//  Instagram
//
//  Created by Stuart Hall on 26/11/11.
//  Copyright (c) 2011 Bytesize. All rights reserved.
//

#import "AppDelegate.h"
#import "ApiKey.h"
#import "InstagramClient.h"
#import "InstagramUser.h"
#import "InstagramMedia.h"

// Private
@interface AppDelegate()
@property (nonatomic, retain) InstagramClient* client;
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize authWebView;
@synthesize client;

- (void)dealloc
{
    self.client = nil;
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    authWebView.authDelegate = self;
    [authWebView startLoadingWithClientId:kInstagramClientId 
                              redirectUrl:kInstagramCallbackUrl 
                                    scope:[NSArray arrayWithObjects:@"likes", @"relationships", @"comments", nil]];
}

#pragma mark - InstagramAuthWebViewDelegate

// Success!
- (void)instagramAuthSucceeded:(NSString*)token {
    // Create a client with our token
    self.client = [InstagramClient clientWithToken:token];
    
    // Fetch our own details
    [client getUser:@"self"
            success:^(InstagramUser* user) {
                NSLog(@"\r\n\r\nGot self : %@ (%@)\r\n\r\n", user.fullname, user.username);
            } 
            failure:^(NSError *error, NSInteger statusCode) {
                NSLog(@"Error fetching user %ld - %@", statusCode, [error localizedDescription]);
            }
     ];
    
    // Fetch a user by ID
    [client getUser:@"128643"
            success:^(InstagramUser* user) {
                NSLog(@"\r\n\r\nGot user : %@ (%@)\r\n\r\n", user.fullname, user.username);
            } 
            failure:^(NSError *error, NSInteger statusCode) {
                NSLog(@"Error fetching user %ld - %@", statusCode, [error localizedDescription]);
            }
     ];
    
    // Perform a search
    [client searchUsers:@"Stuart"
                  limit:3
                success:^(NSArray* users) {
                    for (InstagramUser* user in users)
                        NSLog(@"Search matched user : %@ (%@)", user.fullname, user.username);
            } 
            failure:^(NSError *error, NSInteger statusCode) {
                NSLog(@"Error search users %ld - %@", statusCode, [error localizedDescription]);
            }
     ];
    
    // Fetch the current user feed
    [client getFeed:5
              minId:-1
              maxId:-1
            success:^(NSArray *media) {
                for (InstagramMedia* m in media)
                    NSLog(@"Feed has %@ by %@ (%@) - %ld likes & %ld comments", 
                          m.linkUrl, 
                          m.user.fullname, 
                          m.user.username,
                          m.likeCount,
                          m.commentCount);
            } 
            failure:^(NSError *error, NSInteger statusCode) {
                NSLog(@"Error getting feed %ld - %@", statusCode, [error localizedDescription]);
            }
     ];
}

// Failed because user denied etc
- (void)instagramAuthFailed:(NSString*)error 
            errorReason:(NSString*)errorReason 
       errorDescription:(NSString*)errorMessage {
    NSAlert* alert = [NSAlert alertWithMessageText:errorMessage
                                     defaultButton:@"OK"
                                   alternateButton:nil
                                       otherButton:nil
                         informativeTextWithFormat:@""];
    [alert runModal];
}

// Load error
- (void)instagramAuthLoadFailed:(NSError*)error {
    NSAlert* alert = [NSAlert alertWithError:error];
    [alert runModal];
}

@end
