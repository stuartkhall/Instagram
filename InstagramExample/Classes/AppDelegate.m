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
                NSLog(@"Got user : %@ (%@)", user.fullname, user.username);
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
