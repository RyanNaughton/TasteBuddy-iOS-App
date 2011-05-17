//
//  RestaurantTaggingService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TaggingService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "MenuItem.h"
#import "JSON.h"
#import "Tag.h"

@implementation TaggingService

@synthesize delegate, requestMethod;

- (void)dealloc {
    [delegate release];
    [requestMethod release];
    [super dealloc];
}

-(id) initWithDelegate:(id <TaggingServiceDelegate>) taggingDelegate {
    self = [super init];
    if (self) {
        authTokenRequired = true;
        delegate = [taggingDelegate retain];
    }
    return self;
}


-(void) tagMenuItem:(MenuItem *) menuItem withTag:(NSString *)tag {
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/menu_items/%@/tag.json", menuItem._id];    
    NSLog(@"URL STRING %@", urlString);
    [jsonDictionary setObject:tag forKey:@"value"];
    
    requestMethod = @"PUT";
    
    [self prepareRequest];
    
    
}

-(void) deleteTagFromMenuItem:(MenuItem *) menuItem withTag:(NSString *)tag {
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/menu_items/%@/tag.json", menuItem._id];
    NSLog(@"URL STRING %@", urlString);    
    [jsonDictionary setObject:tag forKey:@"value"];
    
    requestMethod = @"DELETE";
    
    [self prepareRequest];
    
}

-(void) tagRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag {
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/tag.json", restaurant._id];    

    [jsonDictionary setObject:tag forKey:@"value"];

    requestMethod = @"PUT";

    [self prepareRequest];


}

-(void) deleteTagFromRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag {
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/tag.json", restaurant._id];

    [jsonDictionary setObject:tag forKey:@"value"];

    requestMethod = @"DELETE";

    [self prepareRequest];

}

-(void) performRequest {
    
    if (request != nil) {
        [request cancel];
        request = nil;
    }

    NSString *json = [jsonDictionary JSONRepresentation];
    
    NSLog(@"URL STRING %@", urlString);
    NSLog(@"Request Method %@", requestMethod);    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod: requestMethod];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous]; 
}


- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *responseString = [request_passed responseString];
    NSLog(@"Response String %@", responseString);
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
