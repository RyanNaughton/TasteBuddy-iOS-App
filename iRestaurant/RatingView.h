//
//  RatingView.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RatingView : UIView {
    UIView *outlineStarsView;
    UIView *redStarsView;
    UIView *yellowStarsView;
}

@property (nonatomic, retain) UIView *outlineStarsView;
@property (nonatomic, retain) UIView *redStarsView;
@property (nonatomic, retain) UIView *yellowStarsView;

-(id)initWithRating:(float)rating andIsUsersRating:(BOOL)isUserRating;
-(void) setupOutlineStarsView;
-(void) setupRedStarsView;
-(void) setupYellowStarsView;

@end
