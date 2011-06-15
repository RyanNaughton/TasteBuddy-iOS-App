//
//  FestivalsService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "FestivalsService.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "Festival.h"

@implementation FestivalsService

@synthesize delegate;

-(id) initWithDelegate:(id<FestivalsServiceDelegate>) serviceDelegate {
    
    self = [super init];
    if(self) {
        delegate = [serviceDelegate retain];
    }
    return self;
}

-(void) getFestivals {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    NSURL *url = [NSURL URLWithString:@"http://monkey.elhideout.org/festivals.json"];
    
    request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *responseString = [request_passed responseString];
    NSArray *festicalsRetrieved = [responseString JSONValue];
    NSMutableArray *festivals = [[NSMutableArray alloc] initWithCapacity:[festicalsRetrieved count]];
    for (NSDictionary *dict in festicalsRetrieved) {
        [festivals addObject:[[Festival alloc] initWithDictionary:dict]];
    }
    
    [delegate festivalsRetrieved:festivals];
    request = nil;
}


- (void)dealloc {
    [delegate release];
    [super dealloc];
}

@end
