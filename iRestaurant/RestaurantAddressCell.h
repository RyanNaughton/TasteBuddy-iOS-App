//
//  RestaurantAddressCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantAddressCell : UITableViewCell {
    UIButton *addressButton;
    UILabel *neighborhood;
    Restaurant *restaurant;
}

@property (nonatomic, retain) UIButton *addressButton;
@property (nonatomic, retain) UILabel *neighborhood;
@property (nonatomic, retain) Restaurant *restaurant;

-(void)loadRestaurant:(Restaurant *)restaurant;
-(void)addressButtonPressed:(id)sender;

@end
