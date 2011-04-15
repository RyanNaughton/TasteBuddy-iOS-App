//
//  RestaurantSearchCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantSearchCell : UITableViewCell {
    UIImageView *imageView;
    UILabel *name        ;
    UILabel *tags        ;
    UILabel *addressLine1;
    UILabel *addressLine2;
    UILabel *distance    ;
    
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *name        ;
@property (nonatomic, retain) UILabel *tags        ;
@property (nonatomic, retain) UILabel *addressLine1;
@property (nonatomic, retain) UILabel *addressLine2;
@property (nonatomic, retain) UILabel *distance    ;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)loadRestaurant:(Restaurant *)restaurant;
@end
