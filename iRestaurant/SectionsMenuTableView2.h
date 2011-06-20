//
//  SectionsMenuTableView2.h
//  iRestaurant
//
//  Created by Josh Timonen on 6/10/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;
@class Restaurant;
@class MenuViewController;
@class Festival;
@interface SectionsMenuTableView2 : UITableViewController {
    Menu *menu;
    UINavigationController *navController;
    Restaurant *restaurant;
    int sectionExpanded;
    BOOL isExpanded;
    MenuViewController *parentVC;
    Festival *festival;
}

@property (nonatomic, retain) Menu *menu;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, assign) int sectionExpanded;
@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, retain) MenuViewController *parentVC;
@property (nonatomic, retain) Festival *festival;
-(id)initWithMenu:(Menu *)menu_passed andFestival:(Festival*) festival_passed;

@end
