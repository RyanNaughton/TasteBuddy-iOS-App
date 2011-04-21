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
@class Restaurant;
@class IGUIScrollViewImage;

@interface DishHeaderCell : UITableViewCell {
    UILabel *name;
    UILabel *restaurantName;
    UILabel *price;
    RatingView *ratingView;
    IGUIScrollViewImage *svimage;
}

@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *restaurantName;
@property (nonatomic, retain) UILabel *price;
@property (nonatomic, retain) RatingView *ratingView;
@property (nonatomic, retain) IGUIScrollViewImage *svimage;

-(void)loadMenuItem:(MenuItem *)menu_item andRestaurant:(Restaurant *)restaurant;

@end
