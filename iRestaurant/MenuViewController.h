//
//  MenuViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface MenuViewController : UITableViewController {
    Restaurant *restaurant;
}

@property (nonatomic, retain) Restaurant *restaurant;

@end
