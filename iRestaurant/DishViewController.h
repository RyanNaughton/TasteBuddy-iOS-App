//
//  DishViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;
@class MenuItem;

@interface DishViewController : UITableViewController {
    Restaurant *restaurant;
    MenuItem *menu_item;
    NSMutableArray *tableArray;
}

@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) MenuItem *menu_item;
@property (nonatomic, retain) NSMutableArray *tableArray;

-(id)initWithMenuItem:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant_passed;

@end
