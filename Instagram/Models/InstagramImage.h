//
//  InstagramImage.h
//  Instagram
//
//  Created by Stuart Hall on 30/11/11.
//  Copyright (c) 2011 Bytesize. All rights reserved.
//

#import "InstagramModel.h"

@interface InstagramImage : InstagramModel

@property (readonly) NSString* url;
@property (readonly) NSInteger width;
@property (readonly) NSInteger height;

@end
