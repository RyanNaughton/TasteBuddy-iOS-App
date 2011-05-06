//
//  RestaurantTagsCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagService.h"
@class Restaurant;

@interface RestaurantTagsCell : UITableViewCell<TagServiceDelegate> {
    TagService *tagService;
    Restaurant *restaurant;
}

@property (nonatomic, retain) TagService *tagService;
@property (nonatomic, retain) Restaurant *restaurant;

-(void) loadRestaurant:(Restaurant *)restaurantPassed;

@end
