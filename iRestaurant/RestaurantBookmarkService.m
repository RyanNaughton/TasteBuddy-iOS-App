//
//  RestaurantBookmarkService.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantBookmarkService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "JSON.h"

@implementation RestaurantBookmarkService
@synthesize delegate, request;

- (void)dealloc {
    [delegate release];
    [request release];
    [super dealloc];
}

-(id) initWithDelegate:(id <RestaurantBookmarkServiceDelegate>) restaurantDelegate {
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

- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *responseString = [request_passed responseString];
    NSLog(@"response string: %@", responseString);
    
#warning TODO do some stuff with this string
    [delegate doneRating];
    request = nil;
}

@end
