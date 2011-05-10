//
//  AbstractService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 07/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "AbstractService.h"
#import "iRestaurantAppDelegate.h"
#import "AuthenticationResponse.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@implementation AbstractService

@synthesize request, authTokenRequired, authTokenOptional;

-(id) init {
    self = [super init];
    
    if(self) {
        authTokenRequired = NO;
        authTokenOptional = NO;
    }
    
    return self;
}

-(NSString *) authToken {
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.authenticationResponse.authentication_token;
}

-(bool) isLoggedIn {
    NSLog(@"Auth token %@", [self authToken]);
    return !([[self authToken] isEqualToString:@""]);
}

-(void) updatePostData:(NSMutableDictionary *) dictionaryRequest {
    if(authTokenRequired) {        
        [dictionaryRequest setObject:[self authToken] forKey:@"auth_token"];
    } else if([self isLoggedIn] && authTokenOptional) {
        [dictionaryRequest setObject:[self authToken] forKey:@"auth_token"];
    }
}

- (void)dealloc {
    [request release];
    [super dealloc];
}

-(void)requestFailed:(ASIHTTPRequest *)requestPassed {
    if([requestPassed responseStatusCode] == 401) {
        NSLog(@"Invalid username and password");
        NSLog(@"%@", [requestPassed responseString]);
    }
    request = nil;
}

@end
