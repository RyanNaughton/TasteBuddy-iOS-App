//
//  DealsService.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/31/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DealsService.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "iRestaurantAppDelegate.h"

@implementation DealsService

@synthesize delegate, request, jsonDictionary;

-(id) initWithDelegate:(id <DealsServiceDelegate>) dealsDelegate {
    self = [super init];
    if (self) {
        delegate = dealsDelegate;
        //jsonDictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void) dealloc {
    
    [super dealloc];
}

-(void) getDeals {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    //NSString *json = [jsonDictionary JSONRepresentation];
    
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.yipit.com/v1/deals/?lat=%f&lon=%f&radius=%i&tag=restaurants&key=%@", appDelegate.currentLocation.coordinate.latitude, appDelegate.currentLocation.coordinate.longitude, 10, @"mg2ry7FuB3eRxUQR&"];
    NSLog(@"urlString: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous]; 
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSDictionary *responseDictionary = [[request_passed responseString] JSONValue];
    //NSLog(@"response: %@", responseDictionary);
    [delegate dealDataReturned:responseDictionary]; 
}


-(void)requestFailed:(ASIHTTPRequest *)requestPassed {
    int responseCode = [requestPassed responseStatusCode];
    NSLog(@"Error Code  %i :\n\nResponse: %@", responseCode, [requestPassed responseString]);
    
    if (responseCode != 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"We're sorry, but we could not connect to the Deals server" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    request = nil;
}

@end
