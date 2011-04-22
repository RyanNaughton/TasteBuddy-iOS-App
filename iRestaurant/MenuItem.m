//
//  MenuItem.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuItem.h"
#import "Comment.h"

#warning TODO remove this when API updates
#import "JSON.h"

@implementation MenuItem

@synthesize  _id;
@synthesize  name;
@synthesize  average_rating;
@synthesize  tags;
@synthesize  photo_urls;
@synthesize  comments;
@synthesize  pictures;
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
        _id             = [[menuItemDictionary objectForKey:@"_id"] retain];
        name            = [[menuItemDictionary objectForKey:@"name"] retain];
        average_rating  = [[menuItemDictionary objectForKey:@"average_rating"] retain];
        tags            = [[menuItemDictionary objectForKey:@"tags"] retain];
        photo_urls      = [[menuItemDictionary objectForKey:@"photo_urls"] retain];
        pictures        = [[menuItemDictionary objectForKey:@"pictures"] retain];
        restaurant_id   = [[menuItemDictionary objectForKey:@"restaurant_id"] retain];

        comments        = [[NSMutableArray alloc] init];

        
        # warning Code here needs to be changed when API updates.
        //Actual array [menuItemDictionary objectForKey:@"comments"]
        NSString *tempJson = @"[{\"text\": \"Lorem ipsum\", \"user_name\": \"Clark\", \"user_id\": \"456789\"}]";
        NSArray *temporaryArrayOfComments = [tempJson JSONValue];
        NSLog(@"Temp Array of Comment count %@", temporaryArrayOfComments);

        for (NSDictionary *commentDictionary in temporaryArrayOfComments) /* [menuItemDictionary objectForKey:@"comments"] */
        {
            Comment *comment = [[Comment alloc] initWithDictionary:commentDictionary];
            [comments addObject:comment];
            NSLog(@"Comment count %i", [comments count]);
            [comment release];
        }
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
    [pictures       release];
    [restaurant_id  release];
    [super dealloc];
}

@end
