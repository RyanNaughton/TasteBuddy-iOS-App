//
//  RestaurantBookmarkService.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Restaurant;
@class ASIFormDataRequest;

@protocol RestaurantRatingServiceDelegate <NSObject>
-(void) doneRating;
@end

@interface RestaurantBookmarkService : NSObject {
    
}

@end
