//
//  RestaurantButtonsCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RestaurantViewController;

@interface RestaurantButtonsCell : UITableViewCell {
    RestaurantViewController *restaurantViewController;
}

@property (nonatomic, retain) RestaurantViewController *restaurantViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andParentView:(RestaurantViewController *)restaurantViewController_passed;

@end
