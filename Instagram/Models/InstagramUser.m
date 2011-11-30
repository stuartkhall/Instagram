//
//  InstagramUser.m
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//  Copyright (c) 2011 Bytesize. All rights reserved.
//

#import "InstagramUser.h"

// Private
@interface InstagramUser()
@property (nonatomic, retain) NSDictionary* dictionary;
@end

@implementation InstagramUser

@synthesize dictionary;

#pragma mark - Initialisation

+ (InstagramUser*)userWithDictionary:(NSDictionary*)dict {
    InstagramUser* user = [[InstagramUser alloc] init];
    user.dictionary = dict;
    return [user autorelease];
}

+ (NSArray*)usersFromDictionaries:(NSArray*)dicts {
    NSMutableArray* users = [NSMutableArray arrayWithCapacity:[dicts count]];
    for (NSDictionary* userDict in dicts) {
        [users addObject:[self userWithDictionary:userDict]];
    }
    return users;
}

#pragma mark - Memory management

- (void)dealloc {
    self.dictionary = nil;
    
    [super dealloc];
}

#pragma mark - Public properties

- (NSString*)identifier {
    return [dictionary objectForKey:@"id"];
}

- (NSString*)fullname {
    return [dictionary objectForKey:@"full_name"];
}

- (NSString*)username {
    return [dictionary objectForKey:@"username"];
}

- (NSString*)bio {
    return [dictionary objectForKey:@"bio"];
}

- (NSString*)website {
    return [dictionary objectForKey:@"website"];
}

- (NSString*)profilePictureUrl {
    return [dictionary objectForKey:@"profile_picture"];
}

- (NSInteger)followedByCount {
    return [[dictionary valueForKeyPath:@"counts.followed_by"] intValue];
}

- (NSInteger)followersCount {
    return [[dictionary valueForKeyPath:@"counts.follows"] intValue];
}

- (NSInteger)mediaCount {
    return [[dictionary valueForKeyPath:@"counts.media"] intValue];
}

@end
