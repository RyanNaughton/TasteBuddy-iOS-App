//
//  RestaurantRatingService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Restaurant;
@class ASIFormDataRequest;

@protocol RestaurantRatingServiceDelegate <NSObject>
-(void) doneRating;
@end

@interface RestaurantRatingService : NSObject {
    id <RestaurantRatingServiceDelegate> delegate;
    ASIFormDataRequest *request;
}

@property (nonatomic, retain) id <RestaurantRatingServiceDelegate> delegate;
@property (nonatomic, retain) ASIFormDataRequest *request;

-(id) initWithDelegate:(id <RestaurantRatingServiceDelegate>) restaurantDelegate;

-(void) rateRestaurant:(Restaurant *) restaurant withRating:(float) rating andAuthToken:(NSString *) authToken;


@end
