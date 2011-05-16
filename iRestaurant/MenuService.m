//
//  MenuService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuService.h"
#import "Restaurant.h"
#import "Menu.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "Menu.h"

@implementation MenuService

@synthesize delegate;

-(id) initWithDelegate:(id <MenuServiceDelegate>) menuDelegate 
{
    self = [super init];
    if (self) {
        delegate = menuDelegate;
        authTokenOptional = YES;
    }
    return self;
}

-(void) getMenuForRestaurant:(Restaurant *)restaurant
{
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/menu.json", restaurant._id];
    [urlString retain];
    [self prepareRequest];
}

-(void) performRequest {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    

    if([self isLoggedIn]) {
        urlString = [NSString stringWithFormat:@"%@?auth_token=%@", urlString, [self authToken]];        
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous];

    
}

-(void) dealloc
{
    [delegate release];
    [super dealloc];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSString *responseString = [request_passed responseString];
    NSArray *array = [responseString JSONValue];
    
    NSLog(@"menu array: %@", array);
    
    Menu *menu = [[Menu alloc] initWithArray:array];
    request = nil;
    [delegate menuReturned:menu];
}

@end
