//
//  RestaurantTaggingService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@class Restaurant;

@protocol RestaurantTaggingServiceDelegate <NSObject>
    -(void) doneTagging:(NSMutableArray *) tagsFromUser;
@end

@interface RestaurantTaggingService : AbstractService {
    id <RestaurantTaggingServiceDelegate> delegate;
}


@property (nonatomic, retain) id <RestaurantTaggingServiceDelegate> delegate;

-(id) initWithDelegate:(id <RestaurantTaggingServiceDelegate>) restaurantDelegate;

-(void) tagRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag;
-(void) deleteTagFromRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag;
@end
