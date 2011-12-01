//
//  InstagramMedia.h
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
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
@property (readonly) NSString* locationIdentifier;
@property (readonly) NSString* locationLatitude;
@property (readonly) NSString* locationLongitude;
@property (readonly) NSString* locationName;
@property (readonly) NSDate* createdTime;
@property (readonly) NSDictionary* images;

@end
