//
//  RestaurantBookmarkService.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "BookmarkService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "MenuItem.h"
#import "JSON.h"

@implementation BookmarkService
@synthesize delegate, requestMethod;

- (void)dealloc {
    [requestMethod release];
    [delegate release];
    [super dealloc];
}

-(id) initWithDelegate:(id <BookmarkServiceDelegate>) restaurantDelegate {
    self = [super init];
    if (self) {
        delegate = restaurantDelegate;
        authTokenRequired = YES;
    }
    return self;
}

-(void) bookmarkMenuItem:(MenuItem *)menuItem
{
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/menu_items/%@/bookmark.json", menuItem._id];
    requestMethod = @"PUT";
    [self prepareRequest];
}

-(void) deleteBookmarkForMenuItem:(MenuItem *)menuItem
{
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/menu_items/%@/bookmark.json", menuItem._id];
    requestMethod = @"DELETE";
    [self prepareRequest];
}


-(void) bookmarkRestaurant:(Restaurant *) restaurant
{
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/bookmark.json", restaurant._id];
    requestMethod = @"PUT";
    [self prepareRequest];
}

-(void) deleteBookmarkForRestaurant:(Restaurant *) restaurant
{
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/bookmark.json", restaurant._id];
    requestMethod = @"DELETE";
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
    [request setRequestMethod: requestMethod];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setUseCookiePersistence:NO];
    [request setDelegate:self];
    [request startAsynchronous];    
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *responseString = [request_passed responseString];    
    NSDictionary *dictFromJSON = [responseString JSONValue];
    #warning TODO do some stuff with this string
    [delegate doneBookmarking: dictFromJSON];
    request = nil;
}

@end
