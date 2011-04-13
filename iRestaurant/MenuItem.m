//
//  MenuItem.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuItem.h"


@implementation MenuItem

@synthesize  _id;
@synthesize  name;
@synthesize  average_rating;
@synthesize  tags;
@synthesize  photo_urls;
@synthesize  comments;
@synthesize  restaurant_id;

-(id) init {
    self = [super init];
    if (self) {
        // custom init
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *)menuItemDictionary {
    self = [super init];
    if (self) {
        // custom init
        _id             = [menuItemDictionary objectForKey:@"_id"];
        name            = [menuItemDictionary objectForKey:@"name"];
        average_rating  = [menuItemDictionary objectForKey:@"average_rating"];
        tags            = [menuItemDictionary objectForKey:@"tags"];
        photo_urls      = [menuItemDictionary objectForKey:@"photo_urls"];
        comments        = [menuItemDictionary objectForKey:@"comments"];
        restaurant_id   = [menuItemDictionary objectForKey:@"restaurant_id"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    
    MenuItem *newMenuItem = [[MenuItem alloc]init];
    
    newMenuItem._id             = [_id            copy];
    newMenuItem.name            = [name           copy];
    newMenuItem.average_rating  = [average_rating copy];
    newMenuItem.tags            = [tags           copy];
    newMenuItem.photo_urls      = [photo_urls     copy];
    newMenuItem.comments        = [comments       copy];
    newMenuItem.restaurant_id   = [restaurant_id  copy];
    
    return newMenuItem;
}

-(void)dealloc {
    [_id            release];
    [name           release];
    [average_rating release];
    [tags           release];
    [photo_urls     release];
    [comments       release];
    [restaurant_id  release];
    [super dealloc];
}

@end
