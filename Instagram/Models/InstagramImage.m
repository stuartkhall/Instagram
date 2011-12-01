//
//  InstagramImage.m
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//

#import "InstagramImage.h"

@implementation InstagramImage

- (NSString*)url {
    return [self.dictionary objectForKey:@"url"];
}

- (NSInteger)width {
    return [[self.dictionary objectForKey:@"width"] intValue];
}

- (NSInteger)height {
    return [[self.dictionary objectForKey:@"height"] intValue];
}

@end
