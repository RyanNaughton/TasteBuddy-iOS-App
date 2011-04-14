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
    UILabel *address_1;
    UILabel *address_2;
    UILabel *neighborhood;
}

@property(nonatomic, retain) UILabel *address_1;
@property(nonatomic, retain) UILabel *address_2;
@property(nonatomic, retain) UILabel *neighborhood;

-(void)loadRestaurant:(Restaurant *)restaurant;

@end
