//
//  RestaurantTaggingService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Restaurant;
@class ASIFormDataRequest;

@protocol RestaurantTaggingServiceDelegate <NSObject>
    -(void) doneTagging:(NSMutableArray *) tagsFromUser;
@end

@interface RestaurantTaggingService : NSObject {
    id <RestaurantTaggingServiceDelegate> delegate;
    ASIFormDataRequest *request;
}


@property (nonatomic, retain) id <RestaurantTaggingServiceDelegate> delegate;
@property (nonatomic, retain) ASIFormDataRequest *request;


-(id) initWithDelegate:(id <RestaurantTaggingServiceDelegate>) restaurantDelegate;

-(void) tagRestaurant:(Restaurant *) restaurant withTag:(NSString *)tag andAuthToken:(NSString *) authToken;

@end
