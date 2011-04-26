//
//  MenuCategory.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuCategory.h"
#import "MenuSubcategory.h"

@implementation MenuCategory
@synthesize name, menuSubcategories;

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
        menuSubcategories = [[NSMutableArray alloc]init];
        name = [[dictionary objectForKey:@"name"] retain];
        NSLog(@"menu name: %@", name);
        for (NSDictionary *dict in [dictionary objectForKey:@"subcategories"]) {
            MenuSubcategory *menuSubcategory = [[MenuSubcategory alloc]initWithDictionary:dict];
            [menuSubcategories addObject:menuSubcategory];
        }
        
    }
    return self;
}

-(void)dealloc {
    [name release];
    [menuSubcategories release];
    [super dealloc];
}

             
@end
