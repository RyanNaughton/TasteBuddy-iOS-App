//
//  CommentService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 16/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "CommentService.h"
#import "Restaurant.h"
#import "MenuItem.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"

@implementation CommentService

@synthesize delegate;


- (void)dealloc {
    [delegate release];
    [super dealloc];
}

-(id) initWithDelegate:(id <CommentServiceDelegate>) commentDelegate {
    self = [super init];
    if(self) {
        delegate = commentDelegate;
        authTokenRequired = YES;
    }
    return self;
}

-(void) commentOnRestaurant:(Restaurant *) restaurant withComment:(NSString *) text {
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/comment.json", restaurant._id]; 
    [jsonDictionary setObject:text forKey:@"text"];
    [self prepareRequest];
}

-(void) commentOnMenuItem:(MenuItem *) menuItem withComment:(NSString *) text {
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/menu_items/%@/comment.json", menuItem._id];
    [jsonDictionary setObject:text forKey:@"text"];
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

@end
