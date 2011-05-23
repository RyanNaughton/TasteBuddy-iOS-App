//
//  Rating.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "Rating.h"


@implementation Rating

@synthesize ratings_count, average_rating, user_rating;

-(id) initWithUserRating:(NSNumber *)userRating andAverageRating:(NSNumber *)averageRating andRatingsCount:(NSNumber *)ratingsCount
{
    self = [super init];
    if(self) {
        
        if (userRating != nil && [userRating isKindOfClass:[NSNumber class]]) {
            user_rating = [userRating floatValue];
        } else {
            user_rating = 0.0f;
        }
        
        if(averageRating != nil && [averageRating isKindOfClass:[NSNumber class]]) {
            average_rating = [averageRating floatValue];
        } else {
            average_rating = 0.0f;
        }
        
        if(ratingsCount !=nil && [ratingsCount isKindOfClass:[NSNumber class]]) {
            ratings_count = [ratingsCount intValue];
        } else {
            ratings_count = 0;
        }
        
    }
    return self;
}
-(float) sortValue {
    if (user_rating > 0) {
        return user_rating;
    } else {
        return average_rating;
    }
}
@end
