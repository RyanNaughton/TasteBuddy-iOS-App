//
//  Rating.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Rating : NSObject {
    float user_rating;
    float average_rating;
    int ratings_count;
}

@property (nonatomic, assign) float user_rating;
@property (nonatomic, assign) float average_rating;
@property (nonatomic, assign) int ratings_count;

-(id) initWithUserRating:(NSNumber *) userRating andAverageRating:(NSNumber *) averageRating andRatingsCount:(NSNumber *) ratingsCount;

-(float)sortValue;

@end
