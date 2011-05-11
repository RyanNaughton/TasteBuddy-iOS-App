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
@class MenuItem;

@protocol TaggingServiceDelegate <NSObject>
    -(void) doneTagging:(NSMutableArray *) tagsFromUser;
@end

@interface TaggingService : AbstractService {
    id <TaggingServiceDelegate> delegate;
    NSString *requestMethod;
}


@property (nonatomic, retain) id <TaggingServiceDelegate> delegate;
@property (nonatomic, retain) NSString *requestMethod;

-(id) initWithDelegate:(id <TaggingServiceDelegate>) restaurantDelegate;

-(void) tagMenuItem:(MenuItem *) menuItem withTag:(NSString *)tag;
-(void) deleteTagFromMenuItem:(MenuItem *) menuItem withTag:(NSString *)tag;
-(void) tagRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag;
-(void) deleteTagFromRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag;

@end
