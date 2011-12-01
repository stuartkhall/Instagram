//
//  InstagramAuthWebView.h
//  Instagram
//
//  Created by Stuart Hall on 27/11/11.
//

#import <WebKit/WebKit.h>

@protocol InstagramAuthWebViewDelegate;

@interface InstagramAuthWebView : WebView

@property (nonatomic, assign) __weak id<InstagramAuthWebViewDelegate> authDelegate;

// Starts loading the authentication page
- (void)startLoadingWithClientId:(NSString*)cId 
                     redirectUrl:(NSString*)rurl
                           scope:(NSArray*)s;

@end

@protocol InstagramAuthWebViewDelegate <NSObject>

// Success!
- (void)instagramAuthSucceeded:(NSString*)token;

// Failed because user denied etc
- (void)instagramAuthFailed:(NSString*)error 
            errorReason:(NSString*)errorReason 
       errorDescription:(NSString*)errorMessage;

// Load error
- (void)instagramAuthLoadFailed:(NSError*)error;

@end
