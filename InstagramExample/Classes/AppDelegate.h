//
//  AppDelegate.h
//  Instagram
//
//  Created by Stuart Hall on 26/11/11.
//  Copyright (c) 2011 Bytesize. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "InstagramAuthWebView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, InstagramAuthWebViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet InstagramAuthWebView *authWebView;

@end
