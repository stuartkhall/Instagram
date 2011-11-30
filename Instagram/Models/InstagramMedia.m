//
//  InstagramMedia.m
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//  Copyright (c) 2011 Bytesize. All rights reserved.
//

#import "InstagramMedia.h"
#import "InstagramUser.h"

@implementation InstagramMedia

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

//"data": [{
//    "location": {
//        "id": "833",
//        "latitude": 37.77956816727314,
//        "longitude": -122.41387367248539,
//        "name": "Civic Center BART"
//    },
//    "comments": {
//        "count": 16,
//        "data": [ ... ]
//    },
//    "caption": null,
//    "link": "http://instagr.am/p/BXsFz/",
//    "likes": {
//        "count": 190,
//        "data": [{
//            "username": "shayne",
//            "full_name": "Shayne Sweeney",
//            "id": "20",
//            "profile_picture": "..."
//        }, {...subset of likers...}]
//    },
//    "created_time": "1296748524",
//    "images": {
//        "low_resolution": {
//            "url": "http://distillery.s3.amazonaws.com/media/2011/02/03/efc502667a554329b52d9a6bab35b24a_6.jpg",
//            "width": 306,
//            "height": 306
//        },
//        "thumbnail": {
//            "url": "http://distillery.s3.amazonaws.com/media/2011/02/03/efc502667a554329b52d9a6bab35b24a_5.jpg",
//            "width": 150,
//            "height": 150
//        },
//        "standard_resolution": {
//            "url": "http://distillery.s3.amazonaws.com/media/2011/02/03/efc502667a554329b52d9a6bab35b24a_7.jpg",
//            "width": 612,
//            "height": 612
//        }
//    },
//    "type": "image",
//    "filter": "Earlybird",
//    "tags": [],
//    "id": "22987123",
//    "user": {
//        "username": "kevin",
//        "full_name": "Kevin S",
//        "profile_picture": "http://distillery.s3.amazonaws.com/profiles/profile_3_75sq_1295574122.jpg",
//        "id": "3"
//    }
//},
         
@end
