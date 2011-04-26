//
//  MenuSubsection.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 20/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuSubcategory.h"
#import "MenuItem.h"

@implementation MenuSubcategory
@synthesize arrayOfMenuItems, name;

-(id)init {
    self = [super init];
    if (self) {
        // init
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // init
        name = [[dictionary objectForKey:@"name"] retain];
        
        NSLog(@"subcategory name: %@", name);
        
        arrayOfMenuItems = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in [dictionary objectForKey:@"items"]) {
            MenuItem *menuItem = [[MenuItem alloc]initWithDictionary:dict];
            [arrayOfMenuItems addObject:menuItem];
        }
    }
    return self;
}

-(void)dealloc {
    [name release];
    [arrayOfMenuItems release];
    [super dealloc];
}

@end
