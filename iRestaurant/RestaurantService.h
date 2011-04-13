//
//  RestaurantService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Restaurant;
@class ASIHTTPRequest;

@protocol RestaurantServiceDelegate <NSObject>
    -(void)restaurantFetched:(Restaurant *)restaurant;
@end

@interface RestaurantService : NSObject {
    id <RestaurantServiceDelegate> delegate;
}

@property (nonatomic, retain) id <RestaurantServiceDelegate> delegate;

-(id) initWithDelegate:(id<RestaurantServiceDelegate>)restuarantServiceDelgate;

-(void) findById:(NSString *)_id;

- (void)requestFinished:(ASIHTTPRequest *)request_passed;

@end
