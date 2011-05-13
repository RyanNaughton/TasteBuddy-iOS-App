//
//  RatingView.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Rating;

@interface RatingView : UIView <UIActionSheetDelegate> {
    UIView *outlineStarsView;
    UIView *redStarsView;
    UIView *yellowStarsView;
    UIButton *ratingButton;
    UILabel *ratingsLabel;
    int starSize;
}

@property (nonatomic, retain) UIView *outlineStarsView;
@property (nonatomic, retain) UIView *redStarsView;
@property (nonatomic, retain) UIView *yellowStarsView;
@property (nonatomic, retain) UIButton *ratingButton;
@property (nonatomic, retain) UILabel *ratingsLabel;
@property (nonatomic, assign) int starSize;

-(id)initWithRating:(float)rating andStarSize:(int)starSize_passed andIsUserRating:(BOOL)isUserRating andIsEditable:(BOOL)isEditable;

-(id)initWithRating:(float)rating andHowManyRatings:(int)howManyRatings andStarSize:(int)starSize_passed andIsUserRating:(BOOL)isUserRating andIsEditable:(BOOL)isEditable;

-(void) setupOutlineStarsView;
-(void) setupRedStarsView;
-(void) setupYellowStarsView;
-(void) setupRatingButton;
-(void) setupRatingCount:(int)howManyRatings;
-(void) setRating:(float)rating;


-(void) loadRating:(Rating *)rating;

@end
