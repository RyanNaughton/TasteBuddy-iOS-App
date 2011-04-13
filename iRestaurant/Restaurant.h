//
//  Restaurant.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Restaurant : NSObject {
    NSNumber *restaurantid;
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
    
}

@end
