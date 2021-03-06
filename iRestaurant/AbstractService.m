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

@synthesize request, authTokenRequired, authTokenOptional, appDelegate, jsonDictionary, urlString;

-(id) init {
    self = [super init];
    
    if(self) {
        authTokenRequired = NO;
        authTokenOptional = NO;
        appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
        jsonDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(NSString *) authToken {
    return [appDelegate readSavedSetting:@"authentication_token"];
}

-(bool) isLoggedIn {
    return [self authToken] != nil && ![[self authToken] isEqualToString:@""];
}

-(void) prepareRequest {
    if(authTokenRequired) {
        if([self isLoggedIn]){
            [self logInFinished];
        } else {
            [urlString retain];
            [appDelegate login:self];
        }
    } else if([self isLoggedIn] && authTokenOptional) {
        [self logInFinished];
    } else {
            [self performRequest];
    }
}

-(void) logInFinished {
    [jsonDictionary setObject:[self authToken] forKey:@"auth_token"];   
    [self performRequest];
}

- (void)dealloc {
    [urlString release];
    [request release];
    [jsonDictionary release];
    [super dealloc];
}

-(void)requestFailed:(ASIHTTPRequest *)requestPassed {
    int responseCode = [requestPassed responseStatusCode];
    NSLog(@"Error Code  %i :\n\nResponse: %@", responseCode, [requestPassed responseString]);
    if(responseCode == 401) {
        NSLog(@"%@", @"Logging out");
        [appDelegate logout];
    }
    
    if (responseCode != 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"We're sorry, but we could not connect to the TasteBuddy server" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    request = nil;
}

@end
