//
//  AutocompleteService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 14/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "AutocompleteService.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"

@implementation AutocompleteService

@synthesize delegate;

-(void) dealloc {
    [delegate release];
    [super dealloc];
}
-(id) initWithDelegate:(id <AutocompleteServiceDelegate>) serviceDelegate {
    self = [super init];
    if (self) {
        delegate = serviceDelegate;
    }
    return self;
}

-(void) getTerms:(NSString *)term
{
    
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    #warning Replace with real co-ordinates
    double latitude = 41.884432;
    double longitude = -87.643464;
    NSString *near = @"";
    
    NSString *json = [NSString stringWithFormat:@"{\"find\": \"%@\", \"near\": \"%@\", \"coordinates\": [%g, %g]}", 
                      term, near, latitude, longitude];
    
    NSURL *url = [NSURL URLWithString:@"http://monkey.elhideout.org/complete.json"];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void) getPlaces:(NSString *)place
{
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    
    #warning Replace with real co-ordinates
    double latitude = 41.884432;
    double longitude = -87.643464;
    
    NSString *json = [NSString stringWithFormat:@"{\"near\": \"%@\", \"coordinates\": [%g, %g]}", 
                      place, latitude, longitude];
    

    NSURL *url = [NSURL URLWithString:@"http://monkey.elhideout.org/complete.json"];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request startAsynchronous];

}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSDictionary *responseDictionary = [[request_passed responseString] JSONValue];
    NSMutableArray *values = [[NSMutableArray alloc]init];

    for (NSArray *array in [responseDictionary objectEnumerator]) {
        for (NSString *value in array) {
            [values addObject:[value copy]]; //Retain to stop crashes
        }
    }
    
    //[values autorelease];
    [delegate autocompleteFinished:values];
    delegate = nil;
    request = nil;
}

@end
