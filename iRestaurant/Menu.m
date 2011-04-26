//
//  Menu.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Menu.h"
#import "MenuCategory.h"

@implementation Menu

@synthesize arrayOfCategories;

-(id)init {
    self = [super init];
    if (self) {
        // init
    }
    return self;    
}

-(id)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        // init
        arrayOfCategories = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in array) {
            MenuCategory *menuCategory = [[MenuCategory alloc]initWithDictionary:dict];
            [arrayOfCategories addObject:menuCategory];
        }
    }
    return self;    
}

-(void)dealloc {
    [arrayOfCategories release];
    [super dealloc];
}

@end
