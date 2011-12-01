//
//  InstagramMedia.m
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//

#import "InstagramMedia.h"
#import "InstagramUser.h"
#import "InstagramImage.h"

@implementation InstagramMedia

- (NSString*)description {
    return [NSString stringWithFormat:@"Media : %@ by %@", self.linkUrl, self.user.username];
}

- (NSString*)identifier {
    return [self.dictionary objectForKey:@"id"];
}

- (NSString*)linkUrl {
    return [self.dictionary objectForKey:@"link"];
}

- (NSString*)caption {
    return [self.dictionary objectForKey:@"caption"];
}

- (NSInteger)commentCount {
    return [[self.dictionary valueForKeyPath:@"comments.count"] intValue];
}

- (NSInteger)likeCount {
    return [[self.dictionary valueForKeyPath:@"likes.count"] intValue];
}

- (NSString*)filter {
    return [self.dictionary objectForKey:@"filter"];
}

- (InstagramUser*)user {
    return (InstagramUser*)[InstagramUser modelWithDictionary:[self.dictionary objectForKey:@"user"]];
}

- (NSString*)locationIdentifier {
    return [self.dictionary valueForKeyPath:@"location.id"];
}

- (NSString*)locationLatitude {
    return [self.dictionary valueForKeyPath:@"location.latitude"];
}

- (NSString*)locationLongitude {
    return [self.dictionary valueForKeyPath:@"location.longitude"];
}

- (NSString*)locationName {
    return [self.dictionary valueForKeyPath:@"location.name"];
}

- (NSDate*)createdTime {
    return [NSDate dateWithTimeIntervalSince1970:[[self.dictionary objectForKey:@"created_time"] intValue]];
}

- (NSDictionary*)images {
    NSDictionary* rawDict = [self.dictionary objectForKey:@"images"];
    NSMutableDictionary* imageDict = [NSMutableDictionary dictionaryWithCapacity:[rawDict count]];
    for (NSString* key in [rawDict allKeys]) {
        [imageDict setObject:(InstagramImage*)[InstagramImage modelWithDictionary:[rawDict objectForKey:key]] forKey:key];
    }
    return imageDict;
}
         
@end
