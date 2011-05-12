//
//  FavoritesDishesTVC.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantService.h"
@class FavoritesViewController;
@class MenuItem;

@interface FavoritesDishesTVC : UITableViewController<RestaurantServiceDelegate> {
    NSMutableArray *dishesArray;
    IBOutlet FavoritesViewController *favoritesViewController;
    bool isLoading;
    MenuItem *menu_item;
}

@property (nonatomic, retain) FavoritesViewController *favoritesViewController;
@property (nonatomic, retain) NSMutableArray *dishesArray;
@property (nonatomic, assign) bool isLoading;
@property (nonatomic, assign) MenuItem *menu_item;

@end
