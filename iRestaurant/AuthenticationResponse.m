//
//  AuthenticationResponse.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "AuthenticationResponse.h"


@implementation AuthenticationResponse

@synthesize authentication_token;
@synthesize _id;
@synthesize username;
@synthesize first_name;
@synthesize last_name;

-(id) initWithDicationary:(NSDictionary *)responseDictionary {
    self = [super init];
    if (self) {
        //_id                     = [[responseDictionary objectForKey:@"_id"] retain];
        authentication_token    = [[responseDictionary objectForKey:@"authentication_token"] retain];
        username                = [[responseDictionary objectForKey:@"username"] retain];
        first_name              = [[responseDictionary objectForKey:@"first_name"] retain];
        last_name               = [[responseDictionary objectForKey:@"last_name"] retain];
    }
    return self;
}

- (void)dealloc {
    [authentication_token release];
    [_id                  release];
    [username             release];
    [first_name           release];
    [last_name            release];
    [super dealloc];
}
@end
