//
//  Restaurant.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Menu;

@interface Restaurant : NSObject {
    NSString *_id;
    NSString *name;
    NSNumber *average_rating;
    NSString *address_1;
    NSString *address_2;
    NSString *city_town;
    NSString *state_province;
    NSString *country;
    NSString *postal_code;
    NSString *neighborhood;
    NSString *location;
    NSString *website_url;
    NSString *alcohol_type;
    NSNumber *credit_cards;
    NSArray *cuisine_types;
    NSString *delivery;
    NSString *dress_code;
    NSString *group_friendly;
    NSString *kid_friendly;
    NSString *nearest_transit;
    NSNumber *outdoor_seating;
    NSString *parking;
    NSString *phone;
    NSNumber *reservations;
    NSNumber *takeout;
    NSNumber *wheelchair_access;
    NSArray *pictures;
    NSArray *comments;
    NSString *average_meal_price;
    NSNumber *distance;
    
    NSMutableArray *menu_items;
    
    NSMutableArray *menu_metadata;
    
    Menu *menu;
}

@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *average_rating;
@property (nonatomic, retain) NSString *address_1;
@property (nonatomic, retain) NSString *address_2;
@property (nonatomic, retain) NSString *city_town;
@property (nonatomic, retain) NSString *state_province;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *postal_code;
@property (nonatomic, retain) NSString *neighborhood;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *website_url;
@property (nonatomic, retain) NSString *alcohol_type;
@property (nonatomic, retain) NSNumber *credit_cards;
@property (nonatomic, retain) NSArray *cuisine_types;
@property (nonatomic, retain) NSString *delivery;
@property (nonatomic, retain) NSString *dress_code;
@property (nonatomic, retain) NSString *group_friendly;
@property (nonatomic, retain) NSString *kid_friendly;
@property (nonatomic, retain) NSString *nearest_transit;
@property (nonatomic, retain) NSNumber *outdoor_seating;
@property (nonatomic, retain) NSString *parking;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSNumber *reservations;
@property (nonatomic, retain) NSNumber *takeout;
@property (nonatomic, retain) NSNumber *wheelchair_access;
@property (nonatomic, retain) NSArray *pictures;
@property (nonatomic, retain) NSArray *comments;
@property (nonatomic, retain) NSString *average_meal_price;
@property (nonatomic, retain) NSNumber *distance;

@property (nonatomic, retain) NSMutableArray *menu_items;

@property (nonatomic, retain) NSMutableArray *menu_metadata;

@property (nonatomic, retain) Menu *menu;

-(id) initWithDictionary:(NSDictionary *)restaurantDictionary;

@end
