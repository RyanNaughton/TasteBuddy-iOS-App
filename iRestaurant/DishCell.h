//
//  DishesSearchCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItem;
@class RatingView;

@interface DishCell : UITableViewCell {
    
    UIImageView *imageView;
    UILabel *name        ;
    UILabel *tags        ;
    UILabel *price;
    RatingView *ratingView;
    BOOL isFavoriteView;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *name        ;
@property (nonatomic, retain) UILabel *tags        ;
@property (nonatomic, retain) UILabel *price;
@property (nonatomic, retain) RatingView *ratingView;
@property (nonatomic, assign) BOOL isFavoriteView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)loadMenuItem:(MenuItem *)menuItem;
-(void) addRestaurantName:(NSString *)restaurantName;

@end
