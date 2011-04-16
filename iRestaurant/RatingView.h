//
//  RatingView.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RatingView : UIView <UIActionSheetDelegate> {
    UIView *outlineStarsView;
    UIView *redStarsView;
    UIView *yellowStarsView;
    UIButton *ratingButton;
}

@property (nonatomic, retain) UIView *outlineStarsView;
@property (nonatomic, retain) UIView *redStarsView;
@property (nonatomic, retain) UIView *yellowStarsView;
@property (nonatomic, retain) UIButton *ratingButton;

-(id)initWithRating:(float)rating andIsUserRating:(BOOL)isUserRating;
-(id)initWithRating:(float)rating andIsUserRating:(BOOL)isUserRating;
-(void) setupOutlineStarsView;
-(void) setupRedStarsView;
-(void) setupYellowStarsView;
-(void) setupRatingButton;
-(void) rate:(id)sender;

@end
