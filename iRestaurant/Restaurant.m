//
//  Restaurant.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Restaurant.h"
#import "JSON.h"

@implementation Restaurant

@synthesize _id;
@synthesize name;
@synthesize average_rating;
@synthesize address_1;
@synthesize address_2;
@synthesize city_town;
@synthesize state_province;
@synthesize country;
@synthesize postal_code;
@synthesize neighborhood;
@synthesize location;
@synthesize website_url;
@synthesize menu;
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
@synthesize photo_urls;
@synthesize comments;

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
        
        NSString *restaurantDictionaryString = @"{\"id\":\"4d83c94588a847d8a9000002\",\"address_1\":\"1550 E 55th St\",\"address_2\":\"(between Harper Ave & Lake Park Ave)\",\"alcohol_type\":null,\"city_town\":\"Chicago\",\"country\":\"US\",\"credit_cards\":true,\"cuisine_types\":[\"Bakeries\"],\"delivery\":null,\"dress_code\":\"none\",\"group_friendly\":null,\"kid_friendly\":null,\"latitude\":41.7949981689,\"location\":[41.7949981689,-87.5871963501],\"longitude\":-87.5871963501,\"menu\":[],\"name\":\"Bonjour Cafe Bakery\",\"nearest_transit\":null,\"neighborhood\":\"Hyde Park\",\"outdoor_seating\":null,\"parking\":\"Private Lot\",\"phone\":\"(773) 241-5300\",\"postal_code\":\"60615\",\"average_rating\":3.5,\"reservations\":null,\"state_province\":\"IL\",\"takeout\":null,\"website_url\":null,\"wheelchair_access\":true,\"photo_urls\":[\"http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000010/large.jpg?1299694640\"],\"comments\":[]}";
        
        restaurantDictionary = [restaurantDictionaryString JSONValue];
        
        NSLog(@"rest dict: %@", restaurantDictionary);
        
        _id               = [restaurantDictionary objectForKey:@"id"];
        name              = [restaurantDictionary objectForKey:@"name"];
        average_rating    = [restaurantDictionary objectForKey:@"average_rating"];
        address_1         = [restaurantDictionary objectForKey:@"address_1"];
        address_2         = [restaurantDictionary objectForKey:@"address_2"];
        city_town         = [restaurantDictionary objectForKey:@"city_town"];
        state_province    = [restaurantDictionary objectForKey:@"state_province"];
        country           = [restaurantDictionary objectForKey:@"country"];
        postal_code       = [restaurantDictionary objectForKey:@"postal_code"];
        neighborhood      = [restaurantDictionary objectForKey:@"neighborhood"];
        location          = [restaurantDictionary objectForKey:@"location"];
        website_url       = [restaurantDictionary objectForKey:@"website_url"];
        menu              = [restaurantDictionary objectForKey:@"menu"];
        alcohol_type      = [restaurantDictionary objectForKey:@"alcohol_type"];
        credit_cards      = [restaurantDictionary objectForKey:@"credit_cards"];
        cuisine_types     = [restaurantDictionary objectForKey:@"cuisine_types"];
        delivery          = [restaurantDictionary objectForKey:@"delivery"];
        dress_code        = [restaurantDictionary objectForKey:@"dress_code"];
        group_friendly    = [restaurantDictionary objectForKey:@"group_friendly"];
        kid_friendly      = [restaurantDictionary objectForKey:@"kid_friendly"];
        nearest_transit   = [restaurantDictionary objectForKey:@"nearest_transit"];
        outdoor_seating   = [restaurantDictionary objectForKey:@"outdoor_seating"];
        parking           = [restaurantDictionary objectForKey:@"parking"];
        phone             = [restaurantDictionary objectForKey:@"phone"];
        reservations      = [restaurantDictionary objectForKey:@"reservations"];
        takeout           = [restaurantDictionary objectForKey:@"takeout"];
        wheelchair_access = [restaurantDictionary objectForKey:@"wheelchair_access"];
        photo_urls        = [restaurantDictionary objectForKey:@"photo_urls"];
        comments          = [restaurantDictionary objectForKey:@"comments"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    Restaurant *newRestaurant = [[Restaurant alloc]init];
    
    newRestaurant._id      = [_id      copy];
    newRestaurant.name              = [name              copy];
    newRestaurant.average_rating    = [average_rating    copy];
    newRestaurant.address_1         = [address_1         copy];
    newRestaurant.address_2         = [address_2         copy];
    newRestaurant.city_town         = [city_town         copy];
    newRestaurant.state_province    = [state_province    copy];
    newRestaurant.country           = [country           copy];
    newRestaurant.postal_code       = [postal_code       copy];
    newRestaurant.neighborhood      = [neighborhood      copy];
    newRestaurant.location          = [location          copy];
    newRestaurant.website_url       = [website_url       copy];
    newRestaurant.menu              = [menu              copy];
    newRestaurant.alcohol_type      = [alcohol_type      copy];
    newRestaurant.credit_cards      = [credit_cards      copy];
    newRestaurant.cuisine_types     = [cuisine_types     copy];
    newRestaurant.delivery          = [delivery          copy];
    newRestaurant.dress_code        = [dress_code        copy];
    newRestaurant.group_friendly    = [group_friendly    copy];
    newRestaurant.kid_friendly      = [kid_friendly      copy];
    newRestaurant.nearest_transit   = [nearest_transit   copy];
    newRestaurant.outdoor_seating   = [outdoor_seating   copy];
    newRestaurant.parking           = [parking           copy];
    newRestaurant.phone             = [phone             copy];
    newRestaurant.reservations      = [reservations      copy];
    newRestaurant.takeout           = [takeout           copy];
    newRestaurant.wheelchair_access = [wheelchair_access copy];
    newRestaurant.photo_urls        = [photo_urls        copy];
    newRestaurant.comments          = [comments          copy];
    
    return newRestaurant;
}


-(void) dealloc {
    [super dealloc];
    [_id      release];
    [name              release];
    [average_rating    release];
    [address_1         release];
    [address_2         release];
    [city_town         release];
    [state_province    release];
    [country           release];
    [postal_code       release];
    [neighborhood      release];
    [location          release];
    [website_url       release];
    [menu              release];
    [alcohol_type      release];
    [cuisine_types     release];
    [delivery          release];
    [dress_code        release];
    [group_friendly    release];
    [kid_friendly      release];
    [nearest_transit   release];
    [parking           release];
    [phone             release];
    [photo_urls        release];
    [comments          release];
}


@end
