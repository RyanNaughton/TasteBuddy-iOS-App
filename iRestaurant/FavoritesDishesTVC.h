//
//  FavoritesDishesTVC.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FavoritesViewController;

@interface FavoritesDishesTVC : UITableViewController {
    NSMutableArray *dishesArray;
    IBOutlet FavoritesViewController *favoritesViewController;
    bool isLoading;
}

@property (nonatomic, retain) FavoritesViewController *favoritesViewController;
@property (nonatomic, retain) NSMutableArray *dishesArray;
@property (nonatomic, assign) bool isLoading;

@end
