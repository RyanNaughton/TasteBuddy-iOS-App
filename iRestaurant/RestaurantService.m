//
//  RestaurantService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 12/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantService.h"
#import "Restaurant.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@implementation RestaurantService

-(id) initWithDelegate:(id<RestaurantServiceDelegate>)restaurantDelegate {
    self = [super init];
    if(self) {
        delegate = restaurantDelegate;
        authTokenOptional = TRUE;
    }
    return self;
}

-(void) findRestaurantById:(NSString *) _id
{
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@.json", _id];
    [self prepareRequest];
}

-(void) performRequest {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    if([self isLoggedIn]) {
        urlString = [NSString stringWithFormat:@"%@?auth_token=%@", urlString, [self authToken]];        
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous];  
}

- (void)requestFinished:(ASIHTTPRequest *)requestPassed {
   [delegate restauarantRetrieved: [[Restaurant alloc] initWithDictionary:[[requestPassed responseString] JSONValue]]];
    request = nil;
}

@end
