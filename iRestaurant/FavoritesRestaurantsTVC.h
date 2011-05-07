//
//  FavoritesRestaurantsTVC.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FavoritesViewController;

@interface FavoritesRestaurantsTVC : UITableViewController {
    NSMutableArray *restaurantsArray;
    IBOutlet FavoritesViewController *favoritesViewController;
    bool isLoading;
}

@property (nonatomic, retain) NSMutableArray *restaurantsArray;
@property (nonatomic, retain) IBOutlet FavoritesViewController *favoritesViewController;
@property (nonatomic, assign) bool isLoading;

@end
