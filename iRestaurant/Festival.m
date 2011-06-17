//
//  Festival.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Festival.h"
#import "UIDeviceHardware.h"

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
@synthesize distance;
@synthesize header_color;
@synthesize logo;

-(id) initWithDictionary:(NSDictionary *)festivalsDictionary {
    self = [super init];
    if (self) {
        NSLog(@"Festivals Log: %@", festivalsDictionary);
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
        header_color        = [[festivalsDictionary objectForKey:@"header_color"] retain];
        logo                = [[festivalsDictionary objectForKey:@"logo"] retain];
        
        if([[festivalsDictionary objectForKey:@"distance"] isKindOfClass:[NSNull class]]){
            distance = -1.0f;
        } else {
            distance = [[festivalsDictionary objectForKey:@"distance"] floatValue];
        }
    }
    return self;
}
-(UIColor *) color {
    return [UIColor colorWithRed:[[header_color objectForKey:@"red"] intValue]/255.0 green:[[header_color objectForKey:@"green"] intValue]/255.0 blue:[[header_color objectForKey:@"blue"] intValue]/255.0 alpha:1.0];
}
-(NSString *) dates {
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
	[inputDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [inputDateFormatter dateFromString:start_date];
    NSDate *finishDate = [inputDateFormatter dateFromString:end_date];
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *convertedStartDateString = [startDate descriptionWithLocale:currentLocale];
    NSString *convertedFinishDateString = [finishDate descriptionWithLocale:currentLocale];
    
    NSArray *dateStartArray = [convertedStartDateString componentsSeparatedByString:@" "];
    NSArray *dateFinishArray = [convertedFinishDateString componentsSeparatedByString:@" "];

    return [[NSString stringWithFormat:@"%@ %@ - %@ %@", [dateStartArray objectAtIndex:1], [dateStartArray objectAtIndex:2], [dateFinishArray objectAtIndex:1], [dateFinishArray objectAtIndex:2]]stringByReplacingOccurrencesOfString:@"," withString:@""];
}

-(NSString *) urlForDevice {
    UIDeviceHardware *h=[[UIDeviceHardware alloc] init];
    if ([[h platformString] isEqualToString:@"iPhone 4"] || [[h platformString] isEqualToString:@"iPod Touch 4G"]) {
        NSLog(@"we have an iPhone 4");
        return [logo objectForKey:@"standard_resolution"];
    } else {
        return [logo objectForKey:@"low_resolution"];
    }
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
    [header_color release];
    [logo release];
    [super dealloc];
}
@end
