//
//  MenuItem.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuItem.h"
#import "Comment.h"
#import "Tag.h"
#import "Rating.h"

@implementation MenuItem

@synthesize _id;
@synthesize name;
@synthesize photo_urls;
@synthesize comments;
@synthesize pictures;
@synthesize restaurant_id;
@synthesize restaurant_name;
@synthesize price;
@synthesize rating;
@synthesize bookmark;
@synthesize foreign_name;

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
                
        _id             = [[menuItemDictionary objectForKey:@"id"] retain];
        name            = [[menuItemDictionary objectForKey:@"name"] retain];
        photo_urls      = [[menuItemDictionary objectForKey:@"photo_urls"] retain];
        pictures        = [[menuItemDictionary objectForKey:@"pictures"] retain];
        restaurant_id   = [[menuItemDictionary objectForKey:@"restaurant_id"] retain];
        bookmark = [[menuItemDictionary objectForKey:@"bookmark"] boolValue];
        
        foreign_name = [[menuItemDictionary objectForKey:@"foreign_name"] retain];
        
        rating = [[Rating alloc] initWithUserRating:[menuItemDictionary objectForKey:@"user_rating"] andAverageRating:[menuItemDictionary objectForKey:@"average_rating"] andRatingsCount:[menuItemDictionary objectForKey:@"ratings_count"]];
        

        
        NSNumber *priceFromDictionary = [[menuItemDictionary objectForKey:@"price"] retain];
        
        if(priceFromDictionary != nil && [priceFromDictionary isKindOfClass:[NSNumber class]]) {
            price = [priceFromDictionary floatValue];
        } else {
            price = 0.0f;
        }
        [priceFromDictionary release];

        comments = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in [menuItemDictionary objectForKey:@"comments"]) {
            Comment *comment = [[Comment alloc] initWithDictionary:dict];
            [comments addObject:comment];
            [comment release];
        }

        tags = [[NSMutableArray alloc] init];
        NSDictionary *tagDictionary = [menuItemDictionary objectForKey:@"tags"];
        if (![tagDictionary isKindOfClass:[NSNull class]]) {
            for(NSString *key in [tagDictionary allKeys]) {
                Tag *tag = [[Tag alloc] initWithTagValue:key andCount:[[tagDictionary valueForKey:key] intValue]];
                [tags addObject:tag];
                [tag release];
            }
        }
        
        NSArray * user_tags = [[menuItemDictionary objectForKey:@"user_tags"] retain];
        
        if (![user_tags isKindOfClass:[NSNull class]]) {
            for (Tag *tag in tags) {
                tag.isUserTag = [user_tags containsObject:tag.name];
            }
        }
        [user_tags release];
        
    }
    return self;
}

-(void)dealloc {
    [_id            release];
    [name           release];
    [rating         release];
    [tags           release];
    [photo_urls     release];
    [comments       release];
    [pictures       release];
    [restaurant_id  release];
    [super          dealloc];
}

@end
