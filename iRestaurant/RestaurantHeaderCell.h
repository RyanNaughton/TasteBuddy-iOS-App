//
//  RestaurantHeaderCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantHeaderCell : UITableViewCell {
    UIImageView *imageView;
    UILabel *name;
    UILabel *hours;
    UILabel *average_meal;
    UILabel *cuisine_types;

}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *name        ;
@property (nonatomic, retain) UILabel *hours        ;
@property (nonatomic, retain) UILabel *average_meal;
@property (nonatomic, retain) UILabel *cuisine_types;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)loadRestaurant:(Restaurant *)restaurant;
@end
