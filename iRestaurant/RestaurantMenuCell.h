//
//  RestaurantMenuCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;
@class RestaurantViewController;

@interface RestaurantMenuCell : UITableViewCell {
    UIButton *menuButton;
    RestaurantViewController *parentView;
}

@property (nonatomic, retain) UIButton *menuButton;
@property (nonatomic, retain) RestaurantViewController *parentView;

-(void)loadRestaurant:(Restaurant *)restaurant;
-(void)menuButtonPressed:(id)sender;
@end
