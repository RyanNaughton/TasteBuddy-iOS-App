//
//  RestaurantRatingService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantRatingService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "JSON.h"

@implementation RestaurantRatingService

@synthesize delegate, request;

- (void)dealloc {
    [delegate release];
    [request release];
    [super dealloc];
}

-(id) initWithDelegate:(id <RestaurantRatingServiceDelegate>) restaurantDelegate {
    self = [super init];
    if (self) {
        delegate = restaurantDelegate;
    }
    return self;
}

-(void) rateRestaurant:(Restaurant *) restaurant withRating:(float) rating andAuthToken:(NSString *)authToken {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    NSString *json = [NSString stringWithFormat:@"{\"rating\": \"%f\", \"auth_token\": \"%@\"}", rating, authToken];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/rate.json", restaurant._id]];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod: @"PUT"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request startAsynchronous];
}

@end
