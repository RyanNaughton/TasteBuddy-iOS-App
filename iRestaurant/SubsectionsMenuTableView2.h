//
//  SubsectionsMenuTableView2.h
//  iRestaurant
//
//  Created by Josh Timonen on 6/10/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;
@class MenuCategory;
@class Restaurant;

@interface SubsectionsMenuTableView2 : UITableViewController {
    MenuCategory *menuCategory;
    NSMutableArray *simpleMenuItemArray;
    UINavigationController *navController;
    Restaurant *restaurant;
}

@property (nonatomic, retain) MenuCategory *menuCategory;
@property (nonatomic, retain) NSMutableArray *simpleMenuItemArray;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) Restaurant *restaurant;

-(id)initWithMenuCategory:(MenuCategory *)menu_category_passed;

@end
