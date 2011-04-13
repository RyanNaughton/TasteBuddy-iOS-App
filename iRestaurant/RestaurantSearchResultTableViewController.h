//
//  RestaurantSearchResultTableViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RestaurantSearchResultTableViewController : UITableViewController {
    NSMutableArray *restaurantsArray;
}

@property (nonatomic, retain) NSMutableArray *restaurantsArray;

@end
