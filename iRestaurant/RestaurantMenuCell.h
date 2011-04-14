//
//  RestaurantMenuCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantMenuCell : UITableViewCell {
    UIButton *lunchMenuButton;
    UIButton *dinnerMenuButton;
    UIButton *bookmarkItButton;
}

@property (nonatomic, retain) UIButton *lunchMenuButton;
@property (nonatomic, retain) UIButton *dinnerMenuButton;
@property (nonatomic, retain) UIButton *bookmarkItButton;

-(void)loadRestaurant:(Restaurant *)restaurant;
-(void)lunchMenuButtonPressed:(id)sender;
@end
