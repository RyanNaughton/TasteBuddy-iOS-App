//
//  SubsectionsMenuTableView.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/26/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu;

@interface SubsectionsMenuTableView : UITableViewController {
    Menu *menu;
}

@property (nonatomic, retain) Menu *menu;

-(id)initWithMenu:(Menu *)menu_passed;

@end
