//
//  Tag.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Tag.h"


@implementation Tag

@synthesize name, count, isUserTag;

- (void)dealloc {
    [name release];
    [count release];
    [super dealloc];
}

-(id) initWithTagValue:(NSString *) value {
    self = [super init];
    if(self) {
        name = [value retain];
        count = [NSNumber numberWithInt:0];
        isUserTag = false;
    }
    return self;
}

@end
