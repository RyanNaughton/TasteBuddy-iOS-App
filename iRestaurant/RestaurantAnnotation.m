//
//  RestaurantAnnotation.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 24/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantAnnotation.h"


@implementation RestaurantAnnotation

@synthesize coordinate, title, subtitle, restaurant;

-(id) initWithRestaurant:(Restaurant *) restaurantPassed {
    self = [super init];
    if (self) {
        self.restaurant = [restaurantPassed retain];
        self.title = restaurant.name;
        [self setCoordinate:restaurantPassed.location];
    }
    return self;
}

-(void)dealloc{
	[title release];
    [subtitle release];
    [restaurant release];
	[super dealloc];
}

@end
