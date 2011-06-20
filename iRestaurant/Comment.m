//
//  Comment.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 22/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Comment.h"


@implementation Comment
@synthesize _id, user_id, user_name, text;

- (void)dealloc {
    [user_id release];
    [user_name release];
    [text release];
    [super dealloc];
}

-(id)initWithDictionary:(NSDictionary *)commentDictionary
{
    self = [super init];
    if (self) {
        _id       = [[commentDictionary objectForKey:@"_id"] retain];
        user_id   = [[commentDictionary objectForKey:@"user_id"] retain];
        user_name = [[commentDictionary objectForKey:@"username"] retain];
        text      = [[commentDictionary objectForKey:@"text"] retain];
    }
    return self;       
}

@end
