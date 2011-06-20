//
//  MenuViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuService.h"    
@class Restaurant;
@class Menu;
@class Festival;

@interface MenuViewController : UIViewController <MenuServiceDelegate> {
    Restaurant *restaurant;
    MenuService *menuService;
    IBOutlet UITableView *tableView;
    UIActivityIndicatorView *activityIndicator;
    int menuItems;
    Festival *festival;
}

@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) MenuService *menuService;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) Festival *festival;
@property (nonatomic, assign) int menuItems;

- (id) initWithRestaurant:(Restaurant *)restaurant_passed andFestival:(Festival *)festival_passed;
- (void) menuReturned:(Menu *)menu;
- (void) callMenuService;

@end
