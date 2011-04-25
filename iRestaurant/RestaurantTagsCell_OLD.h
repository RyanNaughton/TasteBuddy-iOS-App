//
//  RestaurantTagsCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/20/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantTagsCell_OLD : UITableViewCell {

}

-(void)loadRestaurant:(Restaurant *)restaurant;
-(void)tagButtonPressed:(id)sender;
+ (int) generateCellHeight;

@end
