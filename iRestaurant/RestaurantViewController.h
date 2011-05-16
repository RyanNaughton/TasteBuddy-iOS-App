//
//  RestaurantViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingService.h"
#import "BookmarkService.h"

@class Restaurant;
@class TakePhoto;
@class MenuViewController;

@interface RestaurantViewController : UITableViewController <UIActionSheetDelegate, RatingServiceDelegate, BookmarkServiceDelegate> {
    NSMutableArray *tableArray;
    Restaurant *restaurant;
    int tagsRowHeight;
    TakePhoto *takePhoto;
    MenuViewController *menuViewController;
}

@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, assign) int tagsRowHeight;
@property (nonatomic, retain) TakePhoto *takePhoto;
@property (nonatomic, retain) MenuViewController *menuViewController;

-(id)initWithRestaurant:(Restaurant *)restaurant_passed;
-(void)loadMenu;

-(void)callButtonPressed:(id)sender;
-(void)rateItButtonPressed:(id)sender;
-(void)mapItButtonPressed:(id)sender;
-(void)photoButtonPressed:(id)sender;
-(void)menuButtonPressed:(id)sender;
-(void)bookmarkButtonPressed:(id)sender;
-(void)websiteButtonPressed:(id)sender;

@end
