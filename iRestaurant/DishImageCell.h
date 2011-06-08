//
//  DishImageCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 6/8/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IGUIScrollViewImage;
@class MenuItem;
@class Restaurant;

@interface DishImageCell : UITableViewCell {
    IGUIScrollViewImage *svimage;
    UIView *viewForScrollView;
    UIImageView *singleImageView;
    MenuItem *menu_item;
    Restaurant *restaurant;
}

@property (nonatomic, retain) IGUIScrollViewImage *svimage;
@property (nonatomic, retain) UIView *viewForScrollView;
@property (nonatomic, retain) UIImageView *singleImageView;
@property (nonatomic, retain) MenuItem *menu_item;
@property (nonatomic, retain) Restaurant *restaurant;

-(void)loadMenuItem:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant_passed;
-(void) imageButtonPressed:(id)sender;

@end
