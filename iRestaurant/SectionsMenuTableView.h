//
//  SectionsMenuTableView.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;

@interface SectionsMenuTableView : UITableViewController {
      Menu *menu;
}

@property (nonatomic, retain) Menu *menu;

@end
