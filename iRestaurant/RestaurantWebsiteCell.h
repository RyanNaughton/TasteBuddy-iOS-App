//
//  RestaurantWebsiteCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RestaurantViewController;

@interface RestaurantWebsiteCell : UITableViewCell {
    UIButton *websiteButton;
    RestaurantViewController *restaurantViewController;
}

@property (nonatomic, retain) UIButton *websiteButton;
@property (nonatomic, retain) RestaurantViewController *restaurantViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andRestaruantController:(RestaurantViewController *)restaurantViewControllerPassed;

@end
