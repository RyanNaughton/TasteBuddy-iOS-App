//
//  RestaurantTaggingService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantTaggingService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "JSON.h"
#import "Tag.h"

@implementation RestaurantTaggingService

@synthesize delegate;

- (void)dealloc {
    [delegate release];
    [super dealloc];
}

-(id) initWithDelegate:(id <RestaurantTaggingServiceDelegate>) restaurantDelegate {
    self = [super init];
    if (self) {
        authTokenRequired = true;
        delegate = restaurantDelegate;
    }
    return self;
}
-(void) tagRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    
    [jsonDictionary setObject:tag forKey:@"value"];
    
    [self updatePostData:jsonDictionary];
    
    NSString *json = [jsonDictionary JSONRepresentation];
    
    [jsonDictionary release];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/tag.json", restaurant._id]];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod: @"PUT"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void) deleteTagFromRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    
    [jsonDictionary setObject:tag forKey:@"value"];
    
    [self updatePostData:jsonDictionary];
    
    NSString *json = [jsonDictionary JSONRepresentation];
    
    [jsonDictionary release];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/tag.json", restaurant._id]];
    request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod: @"DELETE"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request startAsynchronous];
}


- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *responseString = [request_passed responseString];
    NSDictionary *responseDictionary = [responseString JSONValue];
    NSArray *userTagsRetrieved = [responseDictionary objectForKey:@"user_tags"];
    NSDictionary *tagsWithCount = [responseDictionary objectForKey:@"tags"];
    
    NSMutableArray *tags = [[NSMutableArray alloc] init];
    for (NSString *value in [tagsWithCount allKeys]) {
        Tag *tag = [[Tag alloc] initWithTagValue:value];
        tag.isUserTag = [userTagsRetrieved containsObject:value];
        tag.count = [[tagsWithCount objectForKey:value] intValue];
        [tags addObject:tag];
    }
    request = nil;
    [delegate doneTagging:tags];
}

@end
