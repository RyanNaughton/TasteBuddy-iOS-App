//
//  RestaurantBookmarkService.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"
@class Restaurant;
@class ASIFormDataRequest;

@protocol RestaurantBookmarkServiceDelegate <NSObject>
-(void) doneBookmarking;
@end

@interface RestaurantBookmarkService : AbstractService {
     id <RestaurantBookmarkServiceDelegate> delegate;
}

@property (nonatomic, retain) id <RestaurantBookmarkServiceDelegate> delegate;

-(id) initWithDelegate:(id <RestaurantBookmarkServiceDelegate>) restaurantDelegate;

-(void) bookmarkRestaurant:(Restaurant *) restaurant;

@end
