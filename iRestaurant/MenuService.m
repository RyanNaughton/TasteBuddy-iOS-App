//
//  MenuService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuService.h"
#import "Restaurant.h"
#import "Menu.h"
#import "JSON.h"
@implementation MenuService

@synthesize delegate;

-(id) initWithDelegate:(id <MenuServiceDelegate>) menuDelegate 
{
    self = [super init];
    if (self) {
        delegate = menuDelegate;
    }
    return self;
}

-(void) getMenuForRestaurant:(Restaurant *)restaurant withMenuSection:(NSString *)section
{
    NSString *url = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/menu_subsection/%d.json", restaurant._id, [restaurant.menu_subsection indexOfObject: section]];
    [self requestFinished:nil];    
}

-(void) dealloc
{
    [delegate release];
    [super dealloc];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSString *json = @"{}";
    NSDictionary *dict = [json JSONValue];
    Menu *menu = [[Menu alloc] initWithDictionary:dict];
    [delegate menuReturned:menu];
}

@end
