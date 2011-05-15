//
//  RestaurantAdditionalInformationCell.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Restaurant;

@interface RestaurantAdditionalInformationCell : UITableViewCell {
    UILabel *alcoholText;
    UILabel *deliveryText;
    UILabel *ccText;
    UILabel *parkingText;
    UILabel *reservationsText;
    UILabel *wifiText;
}
@property (nonatomic, retain) UILabel *alcoholText;
@property (nonatomic, retain) UILabel *deliveryText;
@property (nonatomic, retain) UILabel *ccText;
@property (nonatomic, retain) UILabel *parkingText;
@property (nonatomic, retain) UILabel *reservationsText;
@property (nonatomic, retain) UILabel *wifiText;

-(void)loadRestaurant:(Restaurant *)restaurantPassed;

@end
