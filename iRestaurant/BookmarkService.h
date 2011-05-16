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
@class MenuItem;

@protocol BookmarkServiceDelegate <NSObject>
-(void) doneBookmarking:(NSDictionary *) status;
@end

@interface BookmarkService : AbstractService {
     id <BookmarkServiceDelegate> delegate;
}

@property (nonatomic, retain) id <BookmarkServiceDelegate> delegate;

-(id) initWithDelegate:(id <BookmarkServiceDelegate>) restaurantDelegate;

-(void) bookmarkRestaurant:(Restaurant *) restaurant;
-(void) bookmarkMenuItem:(MenuItem *) menuItem;

@end
