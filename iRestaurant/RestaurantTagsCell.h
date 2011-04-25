//
//  RestaurantTagsCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantTagsCell : UITableViewCell {
    UIImage *circlePlus;
    UIImage *circleCheck;
    
}

@property (nonatomic, retain) UIImage *circlePlus;
@property (nonatomic, retain) UIImage *circleCheck;

-(void) loadRestaurant:(Restaurant *)restaurant;
-(void)tagButtonPressed:(id)sender;

@end
