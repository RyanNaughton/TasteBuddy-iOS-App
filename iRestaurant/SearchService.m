//
//  SearchService.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SearchService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "JSON.h"

#import "iRestaurantAppDelegate.h"

@implementation SearchService
@synthesize location, delegate;

-(id) initWithLocation:(CGPoint)current_location withDelegate:(id<SearchServiceDelegate>)searchServiceDelegate 
{
    self = [super init];
    if (self) {
        location = current_location;
        delegate = searchServiceDelegate;
        authTokenOptional = YES;
    }
    return self;
}

-(void)dealloc {
    [delegate release];
    [super dealloc];
}

-(void)searchByTerm:(NSString *)term andNear:(NSString *)nearString
{
    // Example of how to read from plist. Can also do: [appDelegate setSavedSetting:@"username" withValue:@"my value"];

    
    urlString = @"http://monkey.elhideout.org/search.json";
    
    double latitude = appDelegate.currentLocation.coordinate.latitude; //41.884432;
    double longitude = appDelegate.currentLocation.coordinate.longitude; //-87.643464;
    nearString = @"";
    

    [jsonDictionary setObject:term forKey:@"find"];
    [jsonDictionary setObject:nearString forKey:@"near"];
    [jsonDictionary setObject:[NSArray arrayWithObjects:[NSNumber numberWithDouble: latitude], [NSNumber numberWithDouble: longitude], nil] forKey:@"coordinates"];
    
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
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous];
}

-(void)searchByTerm:(NSString *)term 
{
    [self searchByTerm:term andNear:@""];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
        
    NSString *responseString = [request_passed responseString];
    NSArray *arrayOfDictionaries = [responseString JSONValue];
    NSMutableArray *resultsForDelegate = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in arrayOfDictionaries) {
        Restaurant *restaurant = [[Restaurant alloc]initWithDictionary:dict];
        [resultsForDelegate addObject:restaurant];
        [restaurant release];
    }
    [resultsForDelegate autorelease];
    [delegate searchFinished:resultsForDelegate];
    request = nil;
}

@end
