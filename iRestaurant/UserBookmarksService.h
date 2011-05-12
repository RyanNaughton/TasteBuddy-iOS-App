//
//  UserBookmarksService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 12/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@protocol UserBookmarkServiceDelegate <NSObject>
-(void) doneRetrievingBookmarks:(NSMutableDictionary *) bookmarks;
@end

@interface UserBookmarksService : AbstractService {
    id <UserBookmarkServiceDelegate> delegate;
}

@property (nonatomic, retain) id <UserBookmarkServiceDelegate> delegate;

-(id) initWithDelegate:(id <UserBookmarkServiceDelegate>) restaurantDelegate;

-(void) getUserBookmarks;

@end
