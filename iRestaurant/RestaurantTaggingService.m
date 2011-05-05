//
//  RestaurantTaggingService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantTaggingService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "JSON.h"


@implementation RestaurantTaggingService

@synthesize delegate, request;

- (void)dealloc {
    [delegate release];
    [request release];
    [super dealloc];
}

-(id) initWithDelegate:(id <RestaurantTaggingServiceDelegate>) restaurantDelegate {
    self = [super init];
    if (self) {
        delegate = restaurantDelegate;
    }
    return self;
}
-(void) tagRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag andAuthToken:(NSString *)authToken {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    NSString *json = [NSString stringWithFormat:@"{\"value\": \"%@\", \"auth_token\": \"%@\"}", tag, authToken];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/tag.json", restaurant._id]];
    
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

}

@end
