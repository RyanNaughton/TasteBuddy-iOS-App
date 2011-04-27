//
//  SectionsMenuTableView.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;
@class Restaurant;

@interface SectionsMenuTableView : UITableViewController {
    Menu *menu;
    UINavigationController *navController;
    Restaurant *restaurant;
}

@property (nonatomic, retain) Menu *menu;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) UINavigationController *navController;

@end
