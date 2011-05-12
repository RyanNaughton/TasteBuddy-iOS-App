//
//  UserProfileService.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "UserProfileService.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"

@implementation UserProfileService

@synthesize delegate;


- (void)dealloc {
    [delegate release];
    [super dealloc];
}

-(id) initWithDelegate:(id <UserProfileServiceDelegate>) profileDelegate
{
    self = [super init];
    if (self) {
        delegate = profileDelegate;
        authTokenRequired = YES;
    }
    return self;
}

-(void) getUserProfile 
{
    [self prepareRequest];
}

-(void) performRequest {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/users/profile.json?auth_token=%@", [self authToken]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];  
}

- (void)requestFinished:(ASIHTTPRequest *)requestPassed
{
    NSString *responseString = [requestPassed responseString]; 
    
    NSDictionary *dictionaryFromJSON = [responseString JSONValue];
    
    NSMutableDictionary *profile = [NSMutableDictionary dictionaryWithDictionary:dictionaryFromJSON];
    
    NSLog(@"Profile : %@", profile);
    
    [delegate doneRetrievingProfile:profile];
    request = nil;
}
@end
