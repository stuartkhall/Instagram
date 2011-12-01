//
//  AppDelegate.h
//  Instagram
//
//  Created by Stuart Hall on 26/11/11.
//

#import <Cocoa/Cocoa.h>
#import "InstagramAuthWebView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, InstagramAuthWebViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet InstagramAuthWebView *authWebView;
@property (assign) IBOutlet NSTextView *textView;
@property (assign) IBOutlet NSTextField *userTextField;
@property (assign) IBOutlet NSTextField *userSearchField;

// Current user details
- (IBAction)onCurrentUserDetails:(id)sender;
- (IBAction)onCurrentUserFeed:(id)sender;
- (IBAction)onCurrentUserMedia:(id)sender;
- (IBAction)onCurrentUserLikes:(id)sender;

// Other user details
- (IBAction)onOtherUserDetails:(id)sender;
- (IBAction)onOtherUserMedia:(id)sender;

// User search
- (IBAction)onUserSearch:(id)sender;

@end
