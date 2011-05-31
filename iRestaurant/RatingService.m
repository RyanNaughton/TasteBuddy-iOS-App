//
//  RestaurantRatingService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RatingService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "MenuItem.h"
#import "Rating.h"
#import "JSON.h"

@implementation RatingService

@synthesize delegate;

- (void)dealloc {
    [delegate release];
    [super dealloc];
}

-(id) initWithDelegate:(id <RatingServiceDelegate>) ratingDelegate {
    self = [super init];
    if (self) {
        delegate = ratingDelegate;
        authTokenRequired = TRUE;
    }
    return self;
}

-(void) rateMenuItem:(MenuItem *) menuItem withRating:(float) rating andComments:(NSString *)comments {
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/menu_items/%@/rate.json", menuItem._id];

    [jsonDictionary setObject:[NSNumber numberWithFloat:rating] forKey:@"value"];
    
    [self prepareRequest];

}

-(void) rateRestaurant:(Restaurant *) restaurant withRating:(float) rating andComments:(NSString *)comments {
    
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/rate.json", restaurant._id];

    [jsonDictionary setObject:[NSNumber numberWithFloat:rating] forKey:@"value"];
    
    [self prepareRequest];
    
}

-(void) performRequest {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    NSString *json = [jsonDictionary JSONRepresentation];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod: @"PUT"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *responseString = [request_passed responseString];
    NSDictionary *dict = [responseString JSONValue];
    Rating *rating  = [[Rating alloc] initWithUserRating:[dict objectForKey:@"user_rating"] andAverageRating:[dict objectForKey:@"average_rating"] andRatingsCount:[dict objectForKey:@"ratings_count"]];
    
    [delegate doneRating:rating];
    request = nil;
}

@end
