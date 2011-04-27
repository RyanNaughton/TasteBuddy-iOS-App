//
//  MenuItemsViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/26/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;

@interface MenuItemsViewController : UITableViewController {
    Menu *menu;
    int menuSection;
    int menuSubsection;
}

@property (nonatomic, retain) Menu *menu;
@property (nonatomic, assign) int menuSection;
@property (nonatomic, assign) int menuSubsection;

-(id)initWithMenu:(Menu *)menu_passed andSection:(int)section andSubsection:(int)subSection;

@end
