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
    UILabel *ratingsLabel;
    int starSize;
}

@property (nonatomic, retain) UIView *outlineStarsView;
@property (nonatomic, retain) UIView *redStarsView;
@property (nonatomic, retain) UIView *yellowStarsView;
@property (nonatomic, retain) UILabel *ratingsLabel;
@property (nonatomic, assign) int starSize;

-(id) initWithStarSize:(int) starSizePassed andLabelVisible:(BOOL) isLabelVisible;

-(void) setupOutlineStarsView;
-(void) setupRedStarsView;
-(void) setupYellowStarsView;
-(void) setupRatingCount:(int)howManyRatings;
-(void) setRating:(float)rating;


-(void) loadRating:(Rating *)rating;

@end
