//
//  RestaurantSearchCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;
@class RatingView;

@interface RestaurantSearchCell : UITableViewCell {
    UILabel *name        ;
    UILabel *tags        ;
    UILabel *addressLine1;
    UILabel *distance    ;
    UILabel *averageDishPrice;
    RatingView *ratingView;
    
}

@property (nonatomic, retain) UILabel *name        ;
@property (nonatomic, retain) UILabel *tags        ;
@property (nonatomic, retain) UILabel *addressLine1;
@property (nonatomic, retain) UILabel *distance    ;
@property (nonatomic, retain) UILabel *averageDishPrice;
@property (nonatomic, retain) RatingView *ratingView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)loadRestaurant:(Restaurant *)restaurant;
@end
