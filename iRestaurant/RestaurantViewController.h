//
//  RestaurantViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingService.h"
#import "BookmarkService.h"
#import "RatingPopupViewController.h"
#import "TagService.h"
#import "TaggingService.h"
#import "CommentService.h"

@class Restaurant;
@class TakePhoto;
@class MenuViewController;
@class TagService;

@interface RestaurantViewController : UITableViewController <RatingServiceDelegate, BookmarkServiceDelegate, RatingPopupDelegate, TagServiceDelegate, TaggingServiceDelegate, CommentServiceDelegate> {
    NSMutableArray *tableArray;
    Restaurant *restaurant;
    int tagsRowHeight;
    TakePhoto *takePhoto;
    MenuViewController *menuViewController;
    bool tagsBeingLoaded;
    TagService *tagService;
}

@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, assign) int tagsRowHeight;
@property (nonatomic, retain) TakePhoto *takePhoto;
@property (nonatomic, retain) MenuViewController *menuViewController;
@property (nonatomic, assign) bool tagsBeingLoaded;
@property (nonatomic, assign) TagService *tagService;

-(id)initWithRestaurant:(Restaurant *)restaurant_passed;
-(void)loadMenu;

-(void) callButtonPressed:(id)sender;
-(void) rateItButtonPressed:(id)sender;
-(void) mapItButtonPressed:(id)sender;
-(void) photoButtonPressed:(id)sender;
-(void) menuButtonPressed:(id)sender;
-(void) bookmarkButtonPressed:(id)sender;
-(void) websiteButtonPressed:(id)sender;
-(void) startRatingServiceWithRating:(float)rating andComments:(NSString *)comments;
-(void) newImageLoaded:(NSDictionary *)dict_passed;
-(void) doneCommenting:(NSDictionary *) status;
-(void) buildTableArray;


@end
