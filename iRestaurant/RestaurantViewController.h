//
//  RestaurantViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantRatingService.h"
#import "RestaurantBookmarkService.h"

@class Restaurant;
@class TakePhoto;

@interface RestaurantViewController : UITableViewController <UIActionSheetDelegate, RestaurantRatingServiceDelegate, RestaurantBookmarkServiceDelegate> {
    NSMutableArray *tableArray;
    Restaurant *restaurant;
    int tagsRowHeight;
    TakePhoto *takePhoto;
}

@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, assign) int tagsRowHeight;
@property (nonatomic, retain) TakePhoto *takePhoto;

-(id)initWithRestaurant:(Restaurant *)restaurant_passed;
-(void)loadMenu;

-(void)callButtonPressed:(id)sender;
-(void)rateItButtonPressed:(id)sender;
-(void)mapItButtonPressed:(id)sender;
-(void)photoButtonPressed:(id)sender;
-(void)menuButtonPressed:(id)sender;
-(void)bookmarkButtonPressed:(id)sender;
-(void) doneRating;

@end
