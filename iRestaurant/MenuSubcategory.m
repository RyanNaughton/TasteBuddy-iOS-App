//
//  MenuSubcategory.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuSubcategory.h"
#import "MenuItem.h"

@implementation MenuSubcategory

@synthesize menuItems;
@synthesize name;



-(id) init {
    self = [super init];
    if (self) {
        // custom init
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *) subcategoryDictionary
{
    self = [super init];
    if (self) {
        name = [[subcategoryDictionary objectForKey:@"name"] retain];

        menuItems = [[NSMutableArray alloc] init];        
        for (NSDictionary *dict in [subcategoryDictionary objectForKey:@"items"]) {
            [menuItems addObject:[[MenuItem alloc] initWithDictionary:dict]];
        }
    }
    return self;
}

-(void) dealloc
{
    [menuItems release];
    [name release];
    [super dealloc];
}

@end
