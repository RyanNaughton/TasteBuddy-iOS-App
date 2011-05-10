//
//  RestaurantBookmarkService.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantBookmarkService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "JSON.h"

@implementation RestaurantBookmarkService
@synthesize delegate;

- (void)dealloc {
    [delegate release];
    [super dealloc];
}

-(id) initWithDelegate:(id <RestaurantBookmarkServiceDelegate>) restaurantDelegate {
    self = [super init];
    if (self) {
        delegate = restaurantDelegate;
        authTokenRequired = YES;
    }
    return self;
}

-(void) bookmarkRestaurant:(Restaurant *) restaurant
{
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/bookmark.json", restaurant._id];
    
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
    [request setRequestMethod: @"PUT"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request startAsynchronous];    
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *responseString = [request_passed responseString];
    NSLog(@"bookmark request response string: %@", responseString);
    
    NSDictionary *dictFromJSON = [responseString JSONValue];
    
    if ([[dictFromJSON objectForKey:@"status"] isEqualToString:@"success"]) {
        NSLog(@"success detected");
        NSString *messageString = [NSString stringWithFormat:@"You have successfully bookmarked this restaurant!"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Bookmark Saved!" message:messageString delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else  {
        NSLog(@"dictFromJSON: %@", dictFromJSON);
        NSString *messageString = [NSString stringWithFormat:@"We're sorry, but there was an error."];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:messageString delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    #warning TODO do some stuff with this string
    [delegate doneBookmarking];
    request = nil;
}

@end
