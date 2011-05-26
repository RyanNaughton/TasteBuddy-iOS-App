//
//  AutocompleteService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 14/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "AutocompleteService.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "iRestaurantAppDelegate.h"

@implementation AutocompleteService

@synthesize delegate, lastNear, nearAutoComplete;

-(void) dealloc {
    [delegate release];
    [lastNear release];
    [super dealloc];
}
-(id) initWithDelegate:(id <AutocompleteServiceDelegate>) serviceDelegate {
    self = [super init];
    if (self) {
        delegate = [serviceDelegate retain];
        urlString = @"http://monkey.elhideout.org/complete.json";
        
    }
    return self;
}

-(void) performAutoCompleteWithTerm:(NSString *) term andPlace:(NSString *)place andIsNearAutoComplete:(bool)isNearAutoComplete {
    lastNear = [place retain];
    nearAutoComplete = isNearAutoComplete;
    
    double latitude = appDelegate.currentLocation.coordinate.latitude; //41.884432;
    double longitude = appDelegate.currentLocation.coordinate.longitude; //-87.643464;
    
    [jsonDictionary setObject:term forKey:@"find"];
    if([place isEqualToString:@"Current Location"]) {
        [jsonDictionary setObject:@"" forKey:@"near"];        
    } else {
        [jsonDictionary setObject:place forKey:@"near"];        
    }
    [jsonDictionary setObject:[NSArray arrayWithObjects:[NSNumber numberWithDouble: latitude], [NSNumber numberWithDouble: longitude], nil] forKey:@"coordinates"];
    
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
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSMutableDictionary *responseDictionary = [[request_passed responseString] JSONValue];
        
    NSMutableArray *values = [[NSMutableArray alloc]init];
    if(nearAutoComplete && [@"Current Location" hasPrefix:lastNear]) {
        [values addObject:@"Current Location"];
    }
    for (NSArray *array in [responseDictionary objectEnumerator]) {
        for (NSString *value in array) {
            [values addObject:[value copy]]; //Retain to stop crashes
        }
    }
        
    [delegate autocompleteFinished:responseDictionary withLastNear:lastNear];
    request = nil;
}

@end
