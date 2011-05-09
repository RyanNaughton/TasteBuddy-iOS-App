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
@class MenuViewController;

@interface SectionsMenuTableView : UITableViewController {
    Menu *menu;
    UINavigationController *navController;
    Restaurant *restaurant;
    int sectionExpanded;
    BOOL isExpanded;
    MenuViewController *parentVC;
}

@property (nonatomic, retain) Menu *menu;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, assign) int sectionExpanded;
@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, retain) MenuViewController *parentVC;

@end
