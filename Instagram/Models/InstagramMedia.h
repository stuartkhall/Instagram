//
//  InstagramMedia.h
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//  Copyright (c) 2011 Bytesize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstagramModel.h"

@class InstagramUser;

@interface InstagramMedia : InstagramModel

// Public properties
@property (readonly) NSString* identifier;
@property (readonly) NSString* linkUrl;
@property (readonly) NSString* caption;
@property (readonly) NSInteger commentCount;
@property (readonly) NSInteger likeCount;
@property (readonly) NSString* filter;
@property (readonly) InstagramUser* user;

@end
