//
//  RestaurantRatingService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@class Restaurant;
@class MenuItem;
@class ASIFormDataRequest;
@class Rating;

@protocol RatingServiceDelegate <NSObject>
-(void) doneRating:(Rating *) rating;
@end

@interface RatingService : AbstractService {
    id <RatingServiceDelegate> delegate;
}

@property (nonatomic, retain) id <RatingServiceDelegate> delegate;

-(id) initWithDelegate:(id <RatingServiceDelegate>) ratingDelegate;

-(void) rateRestaurant:(Restaurant *) restaurant withRating:(float) rating;
-(void) rateMenuItem:(MenuItem *) menuItem withRating:(float) rating;


@end
