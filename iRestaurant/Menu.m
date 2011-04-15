//
//  Menu.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Menu.h"


@implementation Menu

@synthesize categories;

-(id) init {
    self = [super init];
    if (self) {
        // custom init
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)menuDictionary
{
    self = [super init];
    if (self) {
        menuDictionary;
    }
    return self;
} 

-(void) dealloc
{
    [categories release];
    [super dealloc];
}

@end

