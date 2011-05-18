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
@class MenuItem;

@interface TagsCell : UITableViewCell<TagServiceDelegate, TaggingServiceDelegate> {
    TagService *tagService;
    Restaurant *restaurant;
    MenuItem *menuItem;
    TaggingService *restaurantTaggingService;
    NSMutableArray *tagButtons;
    NSMutableArray *tags;
    NSMutableArray *tagValues;
}

@property (nonatomic, retain) TagService *tagService;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) MenuItem *menuItem;
@property (nonatomic, retain) NSMutableArray *tagButtons;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) NSMutableArray *tagValues;
@property (nonatomic, retain) TaggingService *restaurantTaggingService;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andContext:(NSString *)context;
-(void) loadRestaurant:(Restaurant *)restaurantPassed;
-(void) loadMenuItem:(MenuItem *)menuItemPassed;
@end
