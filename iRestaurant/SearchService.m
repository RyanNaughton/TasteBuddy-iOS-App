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

@implementation SearchService
@synthesize location, delegate, request;

-(id) init

{
    self = [super init];
    if (self) {
        // custom init
    }
    return self;
}

-(id) initWithLocation:(CGPoint)current_location withDelegate:(id<SearchServiceDelegate>)searchServiceDelegate 
{
    self = [super init];
    if (self) {
        location = current_location;
        delegate = searchServiceDelegate;
        
           }
    return self;
}

-(void)dealloc {
    [delegate release];
    [request release];
    [super dealloc];
}

-(void)searchByTerm:(NSString *)term andNear:(NSString *)nearString
{
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    double latitude = 41.884432;
    double longitude = -87.643464;
    
    NSString *json = [NSString stringWithFormat:@"{\"find\": \"%@\", \"near\": \"%@\", \"coordinates\": [%g, %g]}", 
                      term, nearString, latitude, longitude];
    
    NSURL *url = [NSURL URLWithString:@"http://monkey.elhideout.org/search.json"];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
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
    
    NSLog(@"restaurants: %@", arrayOfDictionaries);
    
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
