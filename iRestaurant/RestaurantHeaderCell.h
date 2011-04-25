//
//  RestaurantHeaderCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;
@class RatingView;

@interface RestaurantHeaderCell : UITableViewCell {
    UIImageView *imageView;
    UILabel *name;
    UILabel *lunch_hours;
    UILabel *dinner_hours;
    UILabel *average_meal;
    UILabel *cuisine_types;
    RatingView *ratingView;
    UIButton *favoriteButton;
    UIImage *greyHeart;
    UIImage *redHeart;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *name        ;
@property (nonatomic, retain) UILabel *lunch_hours        ;
@property (nonatomic, retain) UILabel *dinner_hours       ;
@property (nonatomic, retain) UILabel *average_meal;
@property (nonatomic, retain) UILabel *cuisine_types;
@property (nonatomic, retain) RatingView *ratingView;
@property (nonatomic, retain) UIButton *favoriteButton;
@property (nonatomic, retain) UIImage *greyHeart;
@property (nonatomic, retain) UIImage *redHeart;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) loadRestaurant:(Restaurant *)restaurant;
- (void) favoriteButtonPressed:(id)sender;
@end
