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
    return ![[self authToken] isEqualToString:@""];
}

- (void)dealloc {
    [request release];
    [super dealloc];
}

@end
