//
//  UserAttributesService.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/17/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "UserAttributesService.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "AuthenticationResponse.h"

@implementation UserAttributesService

@synthesize delegate;

-(id) initWithDelegate:(id<UserAttributesServiceDelegate>) serviceDelegate {
    self = [super init];
    if (self) {
        delegate = serviceDelegate;
    }
    return self;
}

-(void) getUserData
{
    
    urlString = @"http://monkey.elhideout.org/users/edit.json";
    
  [self prepareRequest];
}

-(void) performRequest {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/users/edit.json?auth_token=%@", [self authToken]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setUseCookiePersistence:NO];
    [request setDelegate:self];
    [request startAsynchronous];  
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSDictionary *responseDictionary = [[request_passed responseString] JSONValue];
    [delegate attributesServiceComplete:responseDictionary];
    
}
- (void)dealloc {
    [super dealloc];
}

@end
