//
//  RatingView.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//
// 100 x 20 pixels

#import "RatingView.h"


@implementation RatingView
@synthesize outlineStarsView, redStarsView, yellowStarsView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithRating:(float)rating andIsUserRating:(BOOL)isUserRating {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 20)];
    if (self) {
        // init code
        [self setupOutlineStarsView];
        if (rating > 0) {
            if (isUserRating) {
                [self setupYellowStarsView];
                yellowStarsView.frame = CGRectMake(0, 0, rating, 20);
                yellowStarsView.clipsToBounds = TRUE;
            } else {
                [self setupRedStarsView];
                redStarsView.frame = CGRectMake(0, 0, rating, 20);
                redStarsView.clipsToBounds = TRUE;
            }
        }
    }
    return self;
}

-(void) setUserRating:(float)rating {
    
    for (UIView *view in self) {
        if (view == redStarsView) {
            [redStarsView removeFromSuperview];
        }
    }
    
    [self setupYellowStarsView];
    yellowStarsView.frame = CGRectMake(0, 0, rating, 20);
    yellowStarsView.clipsToBounds = TRUE;
}

-(void) setupOutlineStarsView {
    for (int i=0; i < 5; i++) {
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * 20), 0, ((i + 1) * 20), 20)];
        outlineStar.image = [UIImage imageNamed:@"outline_star.png"];
        outlineStar.contentMode = UIViewContentModeScaleAspectFit;
        [outlineStarsView addSubview:outlineStar];
        [outlineStar release];
    }
}

-(void) setupRedStarsView {
    redStarsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    for (int i=0; i < 5; i++) {
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * 20), 0, ((i + 1) * 20), 20)];
        outlineStar.image = [UIImage imageNamed:@"red_star.png"];
        outlineStar.contentMode = UIViewContentModeScaleAspectFit;
        [redStarsView addSubview:outlineStar];
        [outlineStar release];
    }
}

-(void) setupYellowStarsView {
    yellowStarsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    for (int i=0; i < 5; i++) {
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * 20), 0, ((i + 1) * 20), 20)];
        outlineStar.image = [UIImage imageNamed:@"red_star.png"];
        outlineStar.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:outlineStar];
        [outlineStar release];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [outlineStarsView release];
    [redStarsView release];
    [yellowStarsView release];
    [super dealloc];
}

@end
