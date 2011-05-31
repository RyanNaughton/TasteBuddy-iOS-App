//
//  DishViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingService.h"
#import "BookmarkService.h"
#import "RatingPopupViewController.h"
#import "TagService.h"
#import "TaggingService.h"

@class Restaurant;
@class MenuItem;
@class TakePhoto;

@interface DishViewController : UITableViewController <UIActionSheetDelegate, RatingServiceDelegate, BookmarkServiceDelegate, RatingPopupDelegate, TaggingServiceDelegate, TagServiceDelegate> {
    Restaurant *restaurant;
    MenuItem *menu_item;
    NSMutableArray *tableArray;
    TakePhoto *takePhoto;
    TagService *tagService;
    bool tagsBeingLoaded;
}

@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) MenuItem *menu_item;
@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic, retain) TakePhoto *takePhoto;
@property (nonatomic, retain) TagService *tagService;
@property (nonatomic, assign) bool tagsBeingLoaded;


-(id)initWithMenuItem:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant_passed;

-(void)callButtonPressed:(id)sender;
-(void)rateItButtonPressed:(id)sender;
-(void)mapItButtonPressed:(id)sender;
-(void)photoButtonPressed:(id)sender;
-(void)menuButtonPressed:(id)sender;
-(void)bookmarkButtonPressed:(id)sender;
-(void)startRatingServiceWithRating:(float)rating andComments:(NSString *)comments;
-(void) newImageLoaded:(NSDictionary *)dict_passed;
-(void)restaurantButtonPressed:(id)sender;

@end
