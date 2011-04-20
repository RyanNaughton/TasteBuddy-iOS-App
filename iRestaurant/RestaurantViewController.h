//
//  RestaurantViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantViewController : UITableViewController {
    NSMutableArray *tableArray;
    Restaurant *restaurant;
}

@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic, retain) Restaurant *restaurant;

-(id)initWithRestaurant:(Restaurant *)restaurant_passed;
-(void)loadMenu;
@end
