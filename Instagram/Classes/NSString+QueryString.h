//
//  NSString+QueryString.h
//  Instagram
//
//  Created by Stuart Hall on 26/11/11.
//

#import <Foundation/Foundation.h>

@interface NSString (QueryString)

- (NSMutableDictionary *)dictionaryFromQueryComponents;

@end
