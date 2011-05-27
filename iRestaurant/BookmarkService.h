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
    NSString *requestMethod;
}

@property (nonatomic, retain) id <BookmarkServiceDelegate> delegate;
@property (nonatomic, retain) NSString *requestMethod;

-(id) initWithDelegate:(id <BookmarkServiceDelegate>) restaurantDelegate;
-(void) bookmarkRestaurant:(Restaurant *) restaurant;
-(void) bookmarkMenuItem:(MenuItem *) menuItem;
-(void) deleteBookmarkForMenuItem:(MenuItem *)menuItem;
-(void) deleteBookmarkForRestaurant:(Restaurant *) restaurant;

@end
