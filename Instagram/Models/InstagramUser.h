//
//  InstagramUser.h
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//

#import <Foundation/Foundation.h>
#import "InstagramModel.h"

@interface InstagramUser : InstagramModel

// Public properties
@property (readonly) NSString* identifier;
@property (readonly) NSString* fullname;
@property (readonly) NSString* username;
@property (readonly) NSString* bio;
@property (readonly) NSString* website;
@property (readonly) NSString* profilePictureUrl;
@property (readonly) NSInteger followedByCount;
@property (readonly) NSInteger followersCount;
@property (readonly) NSInteger mediaCount;

@end
