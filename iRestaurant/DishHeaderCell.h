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
@class DishViewController;

@interface DishHeaderCell : UITableViewCell {
    UILabel *name;
    UILabel *restaurantName;
    UILabel *price;
    RatingView *ratingView;
    IGUIScrollViewImage *svimage;
    UIView *viewForScrollView;
    UIImageView *singleImageView;
    DishViewController *dvc;
    MenuItem *menu_item;
}

@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *restaurantName;
@property (nonatomic, retain) UILabel *price;
@property (nonatomic, retain) RatingView *ratingView;
@property (nonatomic, retain) IGUIScrollViewImage *svimage;
@property (nonatomic, retain) UIView *viewForScrollView;
@property (nonatomic, retain) UIImageView *singleImageView;
@property (nonatomic, retain) DishViewController *dvc;
@property (nonatomic, retain) MenuItem *menu_item;

-(void)loadMenuItem:(MenuItem *)menu_item andRestaurant:(Restaurant *)restaurant;
-(void)cameraButtonPressed:(id)sender;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDishViewController:(DishViewController *)dvc_passed;
@end
