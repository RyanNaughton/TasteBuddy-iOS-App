//
//  Menu.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Menu.h"
#import "MenuSubcategory.h"

@implementation Menu

@synthesize subcategories;

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
        subcategories = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in [menuDictionary objectForKey:@"subcategories"]) {
            [subcategories addObject:[[MenuSubcategory alloc] initWithDictionary:dict]];
        }
    }
    return self;
} 

-(void) dealloc
{
    [subcategories release];
    [super dealloc];
}

@end

