//
//  RestaurantSearchResultTableViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchViewController;

@interface RestaurantSearchResultTableViewController : UITableViewController{
    NSMutableArray *restaurantsArray;
    IBOutlet SearchViewController *searchViewController;
}

@property (nonatomic, retain) NSMutableArray *restaurantsArray;

@end
