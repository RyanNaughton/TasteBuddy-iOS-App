//
//  Restaurant.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Restaurant.h"
#import "JSON.h"
#import "MenuItem.h"
#import "Menu.h"
#import "Tag.h"
#import "Rating.h"
#import "Comment.h"
#import "hours.h"

@implementation Restaurant

@synthesize _id;
@synthesize name;
@synthesize address_1;
@synthesize address_2;
@synthesize city_town;
@synthesize state_province;
@synthesize country;
@synthesize postal_code;
@synthesize neighborhood;
@synthesize location;
@synthesize website_url;
@synthesize alcohol_type;
@synthesize credit_cards;
@synthesize cuisine_types;
@synthesize delivery;
@synthesize dress_code;
@synthesize group_friendly;
@synthesize kid_friendly;
@synthesize nearest_transit;
@synthesize outdoor_seating;
@synthesize parking;
@synthesize phone;
@synthesize reservations;
@synthesize takeout;
@synthesize wheelchair_access;
@synthesize pictures;
@synthesize comments;
@synthesize average_meal_price;
@synthesize distance;
@synthesize menu_items;
@synthesize menu_metadata;
@synthesize menu;
@synthesize rating;
@synthesize hours;
@synthesize bookmark;

-(id) init {
    self = [super init];
    if (self) {
        // custom init
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *)restaurantDictionary {
    self = [super init];
    if (self) {
       // custom init        
        _id               = [[restaurantDictionary objectForKey:@"id"] retain];
        name              = [[restaurantDictionary objectForKey:@"name"] retain];
        rating = [[Rating alloc] initWithUserRating:[restaurantDictionary objectForKey:@"user_rating"] andAverageRating:[restaurantDictionary objectForKey:@"average_rating"] andRatingsCount:[restaurantDictionary objectForKey:@"ratings_count"]];
        
        bookmark = [[restaurantDictionary objectForKey:@"bookmark"]boolValue];

        address_1         = [[restaurantDictionary objectForKey:@"address_1"] retain];
        address_2         = [[restaurantDictionary objectForKey:@"address_2"] retain];
        city_town         = [[restaurantDictionary objectForKey:@"city_town"] retain];
        state_province    = [[restaurantDictionary objectForKey:@"state_province"] retain];
        country           = [[restaurantDictionary objectForKey:@"country"] retain];
        postal_code       = [[restaurantDictionary objectForKey:@"postal_code"] retain];
        neighborhood      = [[restaurantDictionary objectForKey:@"neighborhood"] retain];
        if(![[restaurantDictionary objectForKey:@"location"] isKindOfClass:[NSNull class]]) {
            location.latitude = [[[restaurantDictionary objectForKey:@"location"] objectAtIndex:0] doubleValue];
            location.longitude = [[[restaurantDictionary objectForKey:@"location"] objectAtIndex:1] doubleValue];

        }
        website_url       = [[restaurantDictionary objectForKey:@"website_url"] retain];
        alcohol_type      = [[restaurantDictionary objectForKey:@"alcohol_type"] retain];
        if([alcohol_type isKindOfClass:[NSNull class]]) {
            alcohol_type = @"Unknown";
        }
        credit_cards      = [[restaurantDictionary objectForKey:@"credit_cards"] retain];
        cuisine_types     = [[restaurantDictionary objectForKey:@"cuisine_types"] retain];
        delivery          = [[restaurantDictionary objectForKey:@"delivery"] retain];
        dress_code        = [[restaurantDictionary objectForKey:@"dress_code"] retain];
        group_friendly    = [[restaurantDictionary objectForKey:@"group_friendly"] retain];
        kid_friendly      = [[restaurantDictionary objectForKey:@"kid_friendly"] retain];
        nearest_transit   = [[restaurantDictionary objectForKey:@"nearest_transit"] retain];
        outdoor_seating   = [[restaurantDictionary objectForKey:@"outdoor_seating"] retain];
        parking           = [[restaurantDictionary objectForKey:@"parking"] retain];
        phone             = [[restaurantDictionary objectForKey:@"phone"] retain];
        reservations      = [[restaurantDictionary objectForKey:@"reservations"] retain];
        takeout           = [[restaurantDictionary objectForKey:@"takeout"] retain];
        wheelchair_access = [[restaurantDictionary objectForKey:@"wheelchair_access"] retain];
        pictures          = [[restaurantDictionary objectForKey:@"pictures"] retain];
        comments          = [[NSMutableArray alloc] init];
        
        hours             =  [[Hours alloc] initWithArray:[[restaurantDictionary objectForKey:@"hours"] retain]];
        
        for (NSDictionary *dict in [restaurantDictionary objectForKey:@"comments"]) {
            Comment *comment = [[Comment alloc] initWithDictionary:dict];
            [comments addObject:comment];
            [comment release];
        }
        
        NSNumber *avgPrice = [[restaurantDictionary objectForKey:@"average_meal_price"] retain];
        
        if(avgPrice != nil && [avgPrice isKindOfClass:[NSNumber class]]){
            average_meal_price = [avgPrice floatValue];
        } else {
            average_meal_price = 0.0f;
        }
        
        distance          = [[restaurantDictionary objectForKey:@"distance"] retain];
        
        menu_items        = [[NSMutableArray alloc] init];
        for(NSDictionary *dict in [restaurantDictionary objectForKey:@"menu_items"])
        {
            MenuItem *menuItem = [[MenuItem alloc] initWithDictionary:dict];
            [menu_items addObject:menuItem];
            [menuItem release];
        }
        
        tags = [[NSMutableArray alloc] init];
        NSDictionary *tagDictionary = [restaurantDictionary objectForKey:@"tags"];

        if (![tagDictionary isKindOfClass:[NSNull class]]) {
            for(NSString *key in [tagDictionary allKeys]) {
                Tag *tag = [[Tag alloc] initWithTagValue:key andCount:[[tagDictionary valueForKey:key] intValue]];
                [tags addObject:tag];
                [tag release];
            }
        }
        
        NSArray * user_tags = [[restaurantDictionary objectForKey:@"user_tags"] retain];
        
        if (![user_tags isKindOfClass:[NSNull class]]) {
            for (Tag *tag in tags) {
                tag.isUserTag = [user_tags containsObject:tag.name];
            }
        }
        [user_tags release];
        menu_metadata = [[restaurantDictionary objectForKey:@"menu_metadata"] retain];
    }

    return self;
}

-(void) dealloc {
    [_id               release];
    [name              release];
    [address_1         release];
    [address_2         release];
    [city_town         release];
    [state_province    release];
    [country           release];
    [postal_code       release];
    [neighborhood      release];
    [website_url       release];
    [alcohol_type      release];
    [cuisine_types     release];
    [delivery          release];
    [dress_code        release];
    [group_friendly    release];
    [kid_friendly      release];
    [nearest_transit   release];
    [parking           release];
    [phone             release];
    [pictures          release];
    [comments          release];
    [menu_items        release];
    [distance           release];
    [menu_metadata      release];
    [menu               release];
    [tags               release];
    [hours              release];
    [super              dealloc];
}


@end
