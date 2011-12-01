//
//  InstagramUser.m
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//

#import "InstagramUser.h"

@implementation InstagramUser

#pragma mark - Public properties

- (NSString*)description {
    return [NSString stringWithFormat:@"User : %@ (%@) - %@", self.fullname, self.username, self.identifier];
}

- (NSString*)identifier {
    return [self.dictionary objectForKey:@"id"];
}

- (NSString*)fullname {
    return [self.dictionary objectForKey:@"full_name"];
}

- (NSString*)username {
    return [self.dictionary objectForKey:@"username"];
}

- (NSString*)bio {
    return [self.dictionary objectForKey:@"bio"];
}

- (NSString*)website {
    return [self.dictionary objectForKey:@"website"];
}

- (NSString*)profilePictureUrl {
    return [self.dictionary objectForKey:@"profile_picture"];
}

- (NSInteger)followedByCount {
    return [[self.dictionary valueForKeyPath:@"counts.followed_by"] intValue];
}

- (NSInteger)followersCount {
    return [[self.dictionary valueForKeyPath:@"counts.follows"] intValue];
}

- (NSInteger)mediaCount {
    return [[self.dictionary valueForKeyPath:@"counts.media"] intValue];
}

@end
