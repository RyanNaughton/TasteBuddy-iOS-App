//
//  DishButtonsCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/18/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface DishButtonsCell : UITableViewCell {
    UIButton *generalInfoButton;
    UIButton *bookmarkItButton;
}

@property (nonatomic, retain) UIButton *generalInfoButton;
@property (nonatomic, retain) UIButton *bookmarkItButton;

-(void)loadRestaurant:(Restaurant *)restaurant_passed;
-(void)generalInfoButtonPressed:(id)sender;
-(void)bookmarkItButtonPressed:(id)sender;

@end
