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

@synthesize delegate, requestMethod;

- (void)dealloc {
    [requestMethod release];
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
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/tag.json", restaurant._id];    

    [jsonDictionary setObject:tag forKey:@"value"];
    
    [self prepareRequest];

    requestMethod = @"PUT";

}

-(void) deleteTagFromRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag {
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/tag.json", restaurant._id];

    [jsonDictionary setObject:tag forKey:@"value"];
    
    [self prepareRequest];

    requestMethod = @"DELETE";
}

-(void) performRequest {
    
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    NSLog(@"RequestMethod %@", requestMethod);

    NSString *json = [jsonDictionary JSONRepresentation];
    
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod: requestMethod];
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
