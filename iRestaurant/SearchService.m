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
    //iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
   // NSLog(@"username: %@", [appDelegate readSavedSetting:@"username"]);
    
    
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    double latitude = 41.884432;
    double longitude = -87.643464;
    nearString = @"";
    
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    
    [jsonDictionary setObject:term forKey:@"find"];
    [jsonDictionary setObject:nearString forKey:@"near"];
    [jsonDictionary setObject:[NSArray arrayWithObjects:[NSNumber numberWithDouble: latitude], [NSNumber numberWithDouble: longitude], nil] forKey:@"coordinates"];
    
    [self updatePostData:jsonDictionary];
    
    NSString *json = [jsonDictionary JSONRepresentation];
    
    [jsonDictionary release];

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
    NSLog(@"response string: %@", responseString);
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
