//
//  DishHeaderCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItem;
@class RatingView;

@interface DishHeaderCell : UITableViewCell {
    UIImageView *imageView;
    UILabel *price;
    RatingView *ratingView;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *price;
@property (nonatomic, retain) RatingView *ratingView;

-(void)loadMenuItem:(MenuItem *)menu_item;

@end
