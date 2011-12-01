//
//  InstagramAuthWebView.m
//  Instagram
//
//  Created by Stuart Hall on 27/11/11.
//

#import "InstagramAuthWebView.h"
#import "NSString+QueryString.h"

@interface InstagramAuthWebView()

@property (nonatomic, retain) NSString* clientId;
@property (nonatomic, retain) NSString* redirectUrl;
@property (nonatomic, retain) NSArray* scope;

@end

@implementation InstagramAuthWebView

@synthesize authDelegate;
@synthesize clientId;
@synthesize redirectUrl;
@synthesize scope;

static NSString* const kInstagramAuthorizeUrl = @"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&display=touch";

- (void)dealloc {
    self.clientId = nil;
    self.redirectUrl = nil;
    self.scope = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
    }
    return self;
}

- (void)startLoadingWithClientId:(NSString*)cId 
                     redirectUrl:(NSString*)rurl
                           scope:(NSArray*)s {
    // Store the details for when we get a response
    self.clientId = cId;
    self.redirectUrl = rurl;
    self.scope = s;
    
    // Handle the delegate ourselves
    self.frameLoadDelegate = self;
    
    // Start the process
    NSString* url = [NSString stringWithFormat:kInstagramAuthorizeUrl, clientId, redirectUrl, 
                     [scope componentsJoinedByString:@"+"]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[self mainFrame] loadRequest:request];
}

- (void)webView:(WebView *)sender didCommitLoadForFrame:(WebFrame *)frame {
    NSString *url = [sender mainFrameURL];
    if ([[url lowercaseString] hasPrefix:[redirectUrl lowercaseString]]) {
        // Extract the token
        NSRange tokenRange = [[url lowercaseString] rangeOfString:@"#access_token="];
        if (tokenRange.location != NSNotFound) {
            // We have our token
            NSString* token = [url substringFromIndex:tokenRange.location + tokenRange.length];
            if (authDelegate) {
                [authDelegate instagramAuthSucceeded:token];
            }
        }
        else {
            // Error, should be something like: error_reason=user_denied&error=access_denied&error_description=The+user+denied+your+request
            NSDictionary* params = [url dictionaryFromQueryComponents];
            if (authDelegate) {
                [authDelegate instagramAuthFailed:[params objectForKey:@"error"]
                                  errorReason:[params objectForKey:@"error_reason"] 
                             errorDescription:[params objectForKey:@"error_description"]];
            }
        }
        
        // Stop loading
        self.frameLoadDelegate = nil;
        [[self mainFrame] stopLoading];
    }
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
    // We failed to load
    if (authDelegate) {
        [authDelegate instagramAuthLoadFailed:error];
    }
}

@end
