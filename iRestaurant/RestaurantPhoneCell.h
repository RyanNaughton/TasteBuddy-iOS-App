//
//  RestaurantPhoneCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantPhoneCell : UITableViewCell {
    UILabel *phone;
}

@property (nonatomic, retain) UILabel *phone;

-(void)loadRestaurant:(Restaurant *)restaurant;

@end
