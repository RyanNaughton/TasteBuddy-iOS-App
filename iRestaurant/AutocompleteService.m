//
//  AutocompleteService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 14/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "AutocompleteService.h"


@implementation AutocompleteService

@synthesize delegate, request, values;

-(id) initWithDelegate:(id <AutocompleteServiceDelegate>) serviceDelegate {
    self = [super init];
    if (self) {
        delegate = serviceDelegate;
    }
    return self;
}

-(void) getTerms:(NSString *)term
{
    values = [[NSArray alloc] initWithObjects:@"Term 1", @"Term 2", @"Term 3", @"Term 4", @"Term 5", @"Term 6", @"Term 7", nil];
    [self requestFinished:nil];
}

-(void) getPlaces:(NSString *)place
{
    values = [[NSArray alloc] initWithObjects:@"Place 1", @"Place 2", @"Place 3", @"Place 4", @"Place 5", @"Place 6", @"Place 7", nil];
    
    [self requestFinished:nil];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    [delegate autocompleteFinished:values];
    delegate = nil;
}

@end
