//
//  SearchService.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SearchService.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import "JSON.h"

@implementation SearchService
@synthesize location, delegate;

-(id) init

{
    self = [super init];
    if (self) {
        // custom init
    }
    return self;
}

-(id) initWithLocation:(CGPoint)current_location withDelegate:(id<SearchServiceDelegate>)searchServiceDelegate 
{
    self = [super init];
    if (self) {
        location = current_location;
        delegate = searchServiceDelegate;
    }
    return self;
}


-(void)searchByTerm:(NSString *)term andNear:(NSString *)nearString
{
    [self requestFinished:nil];
}


-(void)searchByTerm:(NSString *)term 
{
    [self searchByTerm:term andNear:@""];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed 
{
    NSString *json = @"[{\"type\": \"restaurant\", \"name\": \"Boka\", \"phone\": \"(312) 337-6070\", \"address_1\": \"1729 N Halsted St\", \"address_2\": null, \"city_town\": \"Chicago\", \"state_province\": \"IL\", \"rating_average\": 4.1, \"tags\": [\"tag_1\", \"another_tag\"], \"description\": \"apple & chestnut risotto, pickled turnip, wild mushroom sauce\", \"price_average\": \"25\", \"thumbnail_url\": \"http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000001/thumb.jpg?1299694640\", \"photo_urls\": [\"http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000002/large.jpg?7382698134\"], \"id\": \"497ce971395f2f052a494fd5\", \"menu_items\": [{\"type\": \"menu_item\", \"name\": \"Crispy Chicken Thigh\", \"rating_average\": 4.4, \"tags\": [\"salty\", \"crispy\"], \"description\": \"apple & chestnut risotto, pickled turnip, wild mushroom sauce\", \"price\": \"14.00\", \"photo_urls\": [\"http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000014/large.jpg?1299694640\"], \"id\": \"497ce971395f2f052a494fd5\"}]}]";
    
    NSArray *arrayOfDictionaries = [json JSONValue];
    NSMutableArray *resultsForDelegate = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in arrayOfDictionaries) {
        Restaurant *restaurant = [[Restaurant alloc]initWithDictionary:dict];
        [resultsForDelegate addObject:restaurant];
        [restaurant release];
    }
    [delegate searchFinished:resultsForDelegate];

}

@end
