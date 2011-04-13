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
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andRestaurant:(Restaurant *)restaurant;

@end
