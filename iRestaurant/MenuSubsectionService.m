//
//  MenuSubsectionService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 20/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuSubsectionService.h"
#import "Restaurant.h"

@implementation MenuSubsectionService

@synthesize delegate;
@synthesize request;

- (void)dealloc {
    [delegate release];
    [request release];
    [super dealloc];
}

-(id) initWithDelegate:(id <MenuSubsectionServiceDelegate>) menuSubsectionDelegate 
{
    self = [super init];
    if (self) {
        delegate = menuSubsectionDelegate;
    }
    return self;
}

-(void) getMenuSubsectionForRestaurant:(Restaurant *)restaurant withSection:(NSString *)section {
    NSString *url = [NSString stringWithFormat:@"http://monkey.elhideout.org/restaurants/%@/menu_subsection/%d.json", restaurant._id, [restaurant.menu_metadata indexOfObject: section]];
    
    NSLog(@"%@", url);
}

//- (void)requestFinished:(ASIHTTPRequest *)request_passed
//{
//    NSString *json = @"{}";
//    NSDictionary *dict = [json JSONValue];
//    Menu *menu = [[Menu alloc] initWithDictionary:dict];
//    [delegate menuReturned:menu];
//}


@end
