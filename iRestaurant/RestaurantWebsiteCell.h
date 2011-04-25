//
//  RestaurantWebsiteCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantWebsiteCell : UITableViewCell {
    UIButton *websiteButton;
    Restaurant *restaurant;
}

@property (nonatomic, retain) UIButton *websiteButton;
@property (nonatomic, retain) Restaurant *restaurant;

-(void)loadRestaurant:(Restaurant *)restaurant_passed;
-(void) websiteButtonPressed:(id)sender;

@end
