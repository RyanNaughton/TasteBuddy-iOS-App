//
//  TagService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TagService.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "Tag.h"

@implementation TagService

@synthesize delegate;

-(id) initWithDelegate:(id<TagServiceDelegate>) serviceDelegate {

    self = [super init];
    if(self) {
        delegate = serviceDelegate;
    }
    return self;
}

-(void) getTags {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    NSURL *url = [NSURL URLWithString:@"http://monkey.elhideout.org/tags.json"];
    
    request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *responseString = [request_passed responseString];

    NSArray *tagsRetrieved = [responseString JSONValue];
    NSMutableArray *tags = [[NSMutableArray alloc] initWithCapacity:[tagsRetrieved count]];
    for (NSString *value in tagsRetrieved) {
        [tags addObject:[[Tag alloc] initWithTagValue:value]];
    }
    
    [delegate tagsRetrieved:tags];
    request = nil;
}


- (void)dealloc {
    [delegate release];
    [super dealloc];
}

@end
