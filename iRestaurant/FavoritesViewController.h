//
//  FavoritesViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FavoritesDishesTVC;
@class FavoritesRestaurantsTVC;

@interface FavoritesViewController : UIViewController {
    UIButton *restaurantsTabButton;
    UIButton *dishesTabButton;
    UIView *tabView;
    id lastSender;
    IBOutlet FavoritesDishesTVC *favoritesDishesTVC;
    IBOutlet FavoritesRestaurantsTVC *favoritesRestaurantsTVC;
    IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) UIButton *restaurantsTabButton;
@property (nonatomic, retain) UIButton *dishesTabButton;
@property (nonatomic, retain) UIView *tabView;
@property (nonatomic, retain) id lastSender;
@property (nonatomic, retain) IBOutlet FavoritesDishesTVC *favoritesDishesTVC;
@property (nonatomic, retain) IBOutlet FavoritesRestaurantsTVC *favoritesRestaurantsTVC;
@property (nonatomic, retain) UITableView *tableView;

-(void) switchTabs:(UIButton *) onTab;
-(void)switchFavoriteView:(id)sender;

@end
