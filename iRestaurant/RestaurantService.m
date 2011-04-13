//
//  RestaurantService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantService.h"
#import "Restaurant.h"
#import "JSON.h"

@implementation RestaurantService

@synthesize delegate;

-(id) init
{
    self = [super init];
    if (self) {
        // custom init
    }
    return self;
}


-(id) initWithDelegate:(id<RestaurantServiceDelegate>)restuarantServiceDelgate
{
    self = [super init];
    if (self) {
        delegate = restuarantServiceDelgate;
    }
    return self;
}

-(void) findById:(NSString *)_id {
    [self requestFinished:nil];
}

-(void)dealloc {
    [delegate release];
    [super dealloc];
}


- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *json = @"{\"address_1\" :\"1603 E 55th St\", \"address_2\": null, \"alcohol_type\": \"No\", \"city_town\": \"Chicago\", \"country\": \"US\", \"credit_cards\" :true, \"cuisine_types\": [\"Korean\"], \"delivery\": false, \"dress_code\": \"casual\", \"group_friendly\": true, \"kid_friendly\": true, \"location\" :[41.7951749, -87.5871464], \"name\": \"Seoul Corea\", \"nearest_transit\" :null, \"neighborhood\": \"Hyde Park\", \"outdoor_seating\": false, \"parking\": \"Street\", \"phone\": \"(773) 288-1795\", \"postal_code\": \"60615\", \"reservations\": false, \"state_province\": \"IL\", \"takeout\": true, \"website_url\": null, \"wheelchair_access\": true, \"id\": \"4d83c98488a847d8a9000016\", \"average_rating\": 4.1, \"photo_urls\": [], \"comments\": [], \"tags\": []}";
    
    NSDictionary *dict = [json JSONValue];    
    
    Restaurant *restaurantForDelegate = [[Restaurant alloc] initWithDictionary:dict];
    
    [delegate restaurantFetched:restaurantForDelegate];
}

@end
