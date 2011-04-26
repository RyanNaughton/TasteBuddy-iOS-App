//
//  MenuViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuService.h"
@class Restaurant;
@class Menu;
@class MenuService;

@interface MenuViewController_OLD : UITableViewController <MenuServiceDelegate> {
    Restaurant *restaurant;
    MenuService *menuService;
}

@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) MenuService *menuService;

- (id)initWithRestaurant:(Restaurant *)restaurant_passed;
-(void)menuReturned:(Menu *)menu;

@end
