//
//  SimpleMenuTableView.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;

@interface SimpleMenuTableView : UITableViewController {
    Menu *menu;
    NSMutableArray *simpleMenuItemArray;
}

@property (nonatomic, retain) Menu *menu;
@property (nonatomic, retain) NSMutableArray *simpleMenuItemArray;

-(id)initWithMenu:(Menu *)menu_passed;

@end
