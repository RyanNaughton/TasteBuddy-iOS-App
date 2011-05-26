//
//  RestaurantService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 12/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@class Restaurant;

@protocol RestaurantServiceDelegate <NSObject>
    -(void) restaurantRetrieved:(Restaurant *) restuarant;
@end



@interface RestaurantService : AbstractService {
    id<RestaurantServiceDelegate> delegate;
}

-(id) initWithDelegate:(id<RestaurantServiceDelegate>)restaurantDelegate;
-(void) findRestaurantById:(NSString *) _id;

@end
