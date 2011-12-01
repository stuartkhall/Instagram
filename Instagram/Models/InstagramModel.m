//
//  InstagramModel.m
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//

#import "InstagramModel.h"

@implementation InstagramModel

@synthesize dictionary;

#pragma mark - Initialisation

+ (InstagramModel*)modelWithDictionary:(NSDictionary*)dict {
    InstagramModel* user = [[[self class] alloc] init];
    user.dictionary = dict;
    return [user autorelease];
}

+ (NSArray*)modelsFromDictionaries:(NSArray*)dicts {
    NSMutableArray* users = [NSMutableArray arrayWithCapacity:[dicts count]];
    for (NSDictionary* userDict in dicts) {
        [users addObject:[self modelWithDictionary:userDict]];
    }
    return users;
}

#pragma mark - Memory management

- (void)dealloc {
    self.dictionary = nil;
    
    [super dealloc];
}

@end
