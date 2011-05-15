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
    UILabel *deliveryLabel;
    UILabel *ccText;
    UILabel *parkingText;
    UILabel *reservationsText;
    UILabel *wifiText;
}

-(void)loadRestaurant:(Restaurant *)restaurantPassed;

@end
