//
//  InstagramModel.h
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//

#import <Foundation/Foundation.h>

@interface InstagramModel : NSObject

@property (nonatomic, retain) NSDictionary* dictionary;

// Initialises an autoreleased model from a JSON dictionary
+ (InstagramModel*)modelWithDictionary:(NSDictionary*)dict;

// Initialises an array of model from an a array of JSON dictionaries
+ (NSArray*)modelsFromDictionaries:(NSArray*)dicts;

@end
