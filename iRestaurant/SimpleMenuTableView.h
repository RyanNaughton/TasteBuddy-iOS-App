//
//  SimpleMenuTableView.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;
@class Restaurant;
@class Festival;

@interface SimpleMenuTableView : UITableViewController {
    Menu *menu;
    NSMutableArray *simpleMenuItemArray;
    UINavigationController *navController;
    Restaurant *restaurant;
    Festival *festival;
}

@property (nonatomic, retain) Menu *menu;
@property (nonatomic, retain) NSMutableArray *simpleMenuItemArray;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) Festival *festival;

-(id)initWithMenu:(Menu *)menu_passed andFestival:(Festival *)festival_passed;

@end
