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
@class Festival;

@interface SubsectionsMenuTableView2 : UITableViewController {
    MenuCategory *menuCategory;
    NSMutableArray *simpleMenuItemArray;
    UINavigationController *navController;
    Restaurant *restaurant;
    Festival *festival;
}

@property (nonatomic, retain) MenuCategory *menuCategory;
@property (nonatomic, retain) NSMutableArray *simpleMenuItemArray;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) Festival *festival;

-(id)initWithMenuCategory:(MenuCategory *)menu_category_passed andFestival:(Festival *) festival_passed;

@end
