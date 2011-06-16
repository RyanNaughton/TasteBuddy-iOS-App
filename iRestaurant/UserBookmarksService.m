//
//  UserBookmarksService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 12/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "UserBookmarksService.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "MenuItem.h"

@implementation UserBookmarksService

@synthesize delegate;


- (void)dealloc {
    [delegate release];
    [super dealloc];
}

-(id) initWithDelegate:(id <UserBookmarkServiceDelegate>) bookmarkDelegate {
    self = [super init];
    if (self) {
        delegate = bookmarkDelegate;
        authTokenRequired = YES;
    }
    return self;
}

-(void) getUserBookmarks 
{
    urlString = @"http://monkey.elhideout.org/users/bookmarks.json";
    
    [self prepareRequest];
}

-(void) performRequest {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/users/bookmarks.json?auth_token=%@", [self authToken]];

    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setUseCookiePersistence:NO];
    [request setDelegate:self];
    [request startAsynchronous];  
}

- (void)requestFinished:(ASIHTTPRequest *)requestPassed
{
    NSString *responseString = [requestPassed responseString]; 
    NSDictionary *dictionaryFromJSON = [responseString JSONValue];
    
    NSLog(@"dict from JSON, %@", dictionaryFromJSON);
    
    NSMutableDictionary *bookmarksToReturn = [[NSMutableDictionary alloc] initWithDictionary:dictionaryFromJSON];

    [delegate doneRetrievingBookmarks:bookmarksToReturn];
    
    //[bookmarksToReturn setObject:[[NSMutableArray alloc] init] forKey:@"restaurants"];
    //[bookmarksToReturn setObject:[[NSMutableArray alloc] init] forKey:@"menu_items"];    

//    //Get Restaurants
//    NSArray *restaurants = [dictionaryFromJSON objectForKey:@"restaurants"];
//    if (restaurants != nil) {
//        for (NSDictionary *dictionarForConstructor in restaurants) {
//            Restaurant *restaurant =  [[Restaurant alloc] initWithDictionary:dictionarForConstructor];
//            [[bookmarksToReturn objectForKey:@"restaurants"] addObject:restaurant];
//            [restaurant release];
//            [delegate doneRetrievingBookmarks:bookmarksToReturn];
//        }
//    }
    //Get MenuItems
//    NSArray *menuItems = [dictionaryFromJSON objectForKey:@"menu_items_by_restaurant"];
    
//    if (menuItems != nil) {
//        for (NSDictionary *dictionarForConstructor in menuItems) {
//            MenuItem *menu_item =  [[MenuItem alloc] initWithDictionary:dictionarForConstructor];
//            [[bookmarksToReturn objectForKey:@"menu_items"] addObject:menu_item];
//            [menu_item release];
//        }
//    }
//    
    
    request = nil;
}
@end
