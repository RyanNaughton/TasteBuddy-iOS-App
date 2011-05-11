//
//  RestaurantTagsCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagService.h"
#import "TaggingService.h"

@class Restaurant;

@interface RestaurantTagsCell : UITableViewCell<TagServiceDelegate, TaggingServiceDelegate> {
    TagService *tagService;
    Restaurant *restaurant;
    TaggingService *restaurantTaggingService;
    NSMutableArray *tagButtons;
    NSMutableArray *tags;
    NSMutableArray *tagValues;
}

@property (nonatomic, retain) TagService *tagService;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) NSMutableArray *tagButtons;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) NSMutableArray *tagValues;
@property (nonatomic, retain) TaggingService *restaurantTaggingService;

-(void) loadRestaurant:(Restaurant *)restaurantPassed;

@end
