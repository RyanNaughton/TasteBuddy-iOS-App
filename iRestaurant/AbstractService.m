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

@synthesize request, authTokenRequired;

-(NSString *) authToken {
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.authenticationResponse.authentication_token;
}

- (void)dealloc {
    [request release];
    [super dealloc];
}

@end
