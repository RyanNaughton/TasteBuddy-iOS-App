//
//  RestaurantRatingService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantRatingService.h"


@implementation RestaurantRatingService

@synthesize delegate, request;

- (void)dealloc {
    [delegate release];
    [request release];
    [super dealloc];
}

-(id) initWithDelegate:(id <RestaurantRatingServiceDelegate>) restaurantDelegate {
    self = [super init];
    return self;
}

-(void) rateRestaurant:(Restaurant *) restaurant withRating:(float) rating andAuthToken:(NSString *)authToken {
    
}

@end
