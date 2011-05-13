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
        urlString = @"http://monkey.elhideout.org/complete.json";

    }
    return self;
}

-(void) getTerms:(NSString *)term
{
    
    #warning Replace with real co-ordinates
    double latitude = 41.884432;
    double longitude = -87.643464;
    NSString *near = @"";
        
    [jsonDictionary setObject:term forKey:@"find"];
    [jsonDictionary setObject:near forKey:@"near"];
    [jsonDictionary setObject:[NSArray arrayWithObjects:[NSNumber numberWithDouble: latitude], [NSNumber numberWithDouble: longitude], nil] forKey:@"coordinates"];
    
    [self prepareRequest];
}

-(void) getPlaces:(NSString *)place
{    
    #warning Replace with real co-ordinates
    double latitude = 41.884432;
    double longitude = -87.643464;
    
    
    [jsonDictionary setObject:place forKey:@"near"];
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
