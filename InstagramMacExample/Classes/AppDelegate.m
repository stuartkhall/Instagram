//
//  AppDelegate.m
//  Instagram
//
//  Created by Stuart Hall on 26/11/11.
//

#import "AppDelegate.h"
#import "ApiKey.h"
#import "InstagramClient.h"
#import "InstagramUser.h"
#import "InstagramMedia.h"
#import "InstagramImage.h"

// Private
@interface AppDelegate()
@property (nonatomic, retain) InstagramClient* client;
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize authWebView;
@synthesize client;
@synthesize textView;
@synthesize userTextField;
@synthesize userSearchField;

static int const kCount = 5;

- (void)dealloc
{
    self.client = nil;
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Turn off editing for the logging
    [textView setEditable:NO];
    
    // Show the auth view
    authWebView.frame = authWebView.superview.bounds;
    authWebView.authDelegate = self;
    [authWebView startLoadingWithClientId:kInstagramClientId 
                              redirectUrl:kInstagramCallbackUrl 
                                    scope:[NSArray arrayWithObjects:@"likes", @"relationships", @"comments", nil]];
}

#pragma mark - InstagramAuthWebViewDelegate

// Success!
- (void)instagramAuthSucceeded:(NSString*)token {
    // Create a client with our token, you could also persist the token here for next launch
    self.client = [InstagramClient clientWithToken:token];
    
    // Hide the webview
    [authWebView setHidden:YES];
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

#pragma mark - Logging

- (void)logError:(NSString*)request
           error:(NSError*)error
      statusCode:(NSInteger)statusCode {
    NSString* txt = [NSString stringWithFormat:@"Error getting %@ %ld - %@", 
                     request,
                     statusCode, 
                     [error localizedDescription]];
    [textView setString:txt];
}

#pragma mark - Button events

// Current user details
- (IBAction)onCurrentUserDetails:(id)sender {
    // Fetch the current user details
    [textView setString:@"Loading current user..."];
    [client getUser:@"self"
            success:^(InstagramUser *user) {
                [textView setString:[user description]];
            }
            failure:^(NSError *error, NSInteger statusCode) {
                [self logError:@"media" error:error statusCode:statusCode];
            }
     ];
}

- (IBAction)onCurrentUserFeed:(id)sender {
    // Fetch the current user feed
    [textView setString:@"Loading feed..."];
    [client getUserFeed:kCount
                  minId:-1
                  maxId:-1
                 success:^(NSArray *media) {
                     [textView setString:[media description]];
                 }
                 failure:^(NSError *error, NSInteger statusCode) {
                     [self logError:@"media" error:error statusCode:statusCode];
                 }
     ];
}

- (IBAction)onCurrentUserMedia:(id)sender {
    // Fetch the current user media
    [textView setString:@"Loading media..."];
    [client getUserMedia:@"self"
                   count:kCount
                   minId:-1
                   maxId:-1
                 success:^(NSArray *media) {
                     [textView setString:[media description]];
                 }
                 failure:^(NSError *error, NSInteger statusCode) {
                     [self logError:@"media" error:error statusCode:statusCode];
                 }
     ];
}

- (IBAction)onCurrentUserLikes:(id)sender {
    // Fetch the current user likes
    [textView setString:@"Loading likes..."];
    [client getUserLikes:kCount
                   maxId:-1
                 success:^(NSArray *media) {
                     [textView setString:[media description]];
                 }
                 failure:^(NSError *error, NSInteger statusCode) {
                     [self logError:@"likes" error:error statusCode:statusCode];
                 }
     ];
}

// Other user details
- (IBAction)onOtherUserDetails:(id)sender {
    // Fetch the user details
    [textView setString:@"Loading user..."];
    [client getUser:[userTextField stringValue]
            success:^(InstagramUser *user) {
                [textView setString:[user description]];
            }
            failure:^(NSError *error, NSInteger statusCode) {
                [self logError:@"media" error:error statusCode:statusCode];
            }
     ];
}

- (IBAction)onOtherUserMedia:(id)sender {
    // Fetch the user media
    [textView setString:@"Loading media..."];
    [client getUserMedia:[userTextField stringValue]
                   count:kCount
                   minId:-1
                   maxId:-1
                 success:^(NSArray *media) {
                     [textView setString:[media description]];
                 }
                 failure:^(NSError *error, NSInteger statusCode) {
                     [self logError:@"media" error:error statusCode:statusCode];
                 }
     ];
}
    
- (IBAction)onUserSearch:(id)sender {
    [textView setString:@"Searching users..."];
    [client searchUsers:[userSearchField stringValue]
                  limit:kCount
                success:^(NSArray *users) {
                    [textView setString:[users description]];
                } 
                failure:^(NSError *error, NSInteger statusCode) {
                    [self logError:@"user search" error:error statusCode:statusCode];
                }
     ];
}

@end
