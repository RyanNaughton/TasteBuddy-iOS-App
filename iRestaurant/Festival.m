//
//  Festival.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Festival.h"

@implementation Festival

@synthesize _id;
@synthesize name;
@synthesize address_description;
@synthesize address_1;
@synthesize city_town;
@synthesize state_province;
@synthesize postal_code;
@synthesize website_url;
@synthesize start_date;
@synthesize end_date;
@synthesize latitude;
@synthesize longitude;

-(id) initWithDictionary:(NSDictionary *)festivalsDictionary {
    self = [super init];
    if (self) {
        _id                 = [[festivalsDictionary objectForKey:@"id"] retain];
        name                = [[festivalsDictionary objectForKey:@"name"] retain];
        address_description = [[festivalsDictionary objectForKey:@"address_description"] retain];
        address_1           = [[festivalsDictionary objectForKey:@"address_1"] retain];
        city_town           = [[festivalsDictionary objectForKey:@"city_town"] retain];
        state_province      = [[festivalsDictionary objectForKey:@"state_province"] retain];
        postal_code         = [[festivalsDictionary objectForKey:@"postal_code"] retain];
        website_url         = [[festivalsDictionary objectForKey:@"website_url"] retain];
        start_date          = [[festivalsDictionary objectForKey:@"start_date"] retain];
        end_date            = [[festivalsDictionary objectForKey:@"end_date"] retain];
        latitude            = [[festivalsDictionary objectForKey:@"latitude"] retain];
        longitude           = [[festivalsDictionary objectForKey:@"longitude"] retain];
    }
    return self;
}

-(void) dealloc {
    [_id release];
    [name release];
    [address_description release];
    [address_1 release];
    [city_town release];
    [state_province release];
    [postal_code release];
    [website_url release];
    [start_date release];
    [end_date release];
    [latitude release];
    [longitude release];
    [super dealloc];
}
@end
