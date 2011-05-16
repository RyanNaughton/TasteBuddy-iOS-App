//
//  FavoritesViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBookmarksService.h"
@class FavoritesDishesTVC;
@class FavoritesRestaurantsTVC;

@interface FavoritesViewController : UIViewController <UserBookmarkServiceDelegate> {
    UIButton *restaurantsTabButton;
    UIButton *dishesTabButton;
    UIView *tabView;
    id lastSender;
    IBOutlet FavoritesDishesTVC *favoritesDishesTVC;
    IBOutlet FavoritesRestaurantsTVC *favoritesRestaurantsTVC;
    IBOutlet UITableView *tableView;
    UserBookmarksService *ubs;
    BOOL initialSetup;
}

@property (nonatomic, retain) UIButton *restaurantsTabButton;
@property (nonatomic, retain) UIButton *dishesTabButton;
@property (nonatomic, retain) UIView *tabView;
@property (nonatomic, retain) id lastSender;
@property (nonatomic, retain) IBOutlet FavoritesDishesTVC *favoritesDishesTVC;
@property (nonatomic, retain) IBOutlet FavoritesRestaurantsTVC *favoritesRestaurantsTVC;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UserBookmarksService *ubs;
@property (nonatomic, assign) BOOL initialSetup;

-(void) setActiveTab:(UIButton *) activeTab;
-(void)switchFavoriteView:(id)sender;
-(void) checkLogin;
-(void)setupNavBarContent;

@end
