//
//  RatingView.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//
// 100 x 20 pixels

#import "RatingView.h"
#import "Rating.h"

@implementation RatingView
@synthesize outlineStarsView, redStarsView, yellowStarsView, starSize, ratingsLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithStarSize:(int) starSizePassed andLabelVisible:(BOOL) isLabelVisible {
    if(isLabelVisible) {
        self = [super initWithFrame:CGRectMake(0, 0, 150, starSizePassed)];
    } else {
        self = [super initWithFrame:CGRectMake(0, 0, 100, starSizePassed)];
    }
    if(self) {
        starSize = starSizePassed;
        [self setupOutlineStarsView];
        
        ratingsLabel = [[UILabel alloc]initWithFrame:CGRectMake (((starSize * 5) + 5), 2, 100, starSize)];
        ratingsLabel.textColor = [UIColor darkGrayColor];
        ratingsLabel.font = [UIFont systemFontOfSize:12];
        ratingsLabel.hidden = !isLabelVisible;
        [self addSubview:ratingsLabel];

    }
    
    return self;
}

// sets user rating to a float passed in. rating is a % (rating/100)
-(void) setUserRating:(float)rating {
    [redStarsView removeFromSuperview];
    [self setupYellowStarsView];
    yellowStarsView.frame = CGRectMake(0, 0, ((rating * (starSize *5)) / 100), starSize);
    yellowStarsView.clipsToBounds = TRUE;
}

-(void) setRating:(float)rating {
    [self setupRedStarsView];
    redStarsView.frame = CGRectMake(0, 0, ((rating * (starSize *5)) / 100), starSize);
    redStarsView.clipsToBounds = TRUE;
}


-(void) setupOutlineStarsView {
    outlineStarsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (starSize * 5), starSize)];
    for (int i=0; i < 5; i++) {
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * starSize), 0, starSize, starSize)];
        outlineStar.image = [UIImage imageNamed:@"outline_star.png"];
        outlineStar.contentMode = UIViewContentModeScaleToFill;
        [outlineStarsView addSubview:outlineStar];
        [outlineStar release];
    }
}

-(void) setupRedStarsView {
    redStarsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (starSize * 5), starSize)];
    for (int i=0; i < 5; i++) {
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * starSize), 0, starSize, starSize)];
        outlineStar.image = [UIImage imageNamed:@"red_star.png"];
        outlineStar.contentMode = UIViewContentModeScaleToFill;
        [redStarsView addSubview:outlineStar];
        [outlineStar release];
    }
    [self addSubview:redStarsView];
}

-(void) setupYellowStarsView {
    yellowStarsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (starSize * 5), starSize)];
    for (int i=0; i < 5; i++) {
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * starSize), 0, starSize, starSize)];
        outlineStar.image = [UIImage imageNamed:@"yellow_star.png"];
        outlineStar.contentMode = UIViewContentModeScaleToFill;
        [yellowStarsView addSubview:outlineStar];
        [outlineStar release];
    }
    [self addSubview:yellowStarsView];
}

-(void)setupRatingCount:(int)howManyRatings {
    ratingsLabel.text = [NSString stringWithFormat:@"%i ratings", howManyRatings];
}


-(void) loadRating:(Rating *)rating {
    [self setupRatingCount:rating.ratings_count];
    [self setRating:rating.average_rating * 20];
    if (rating.user_rating > 0) {
        [self setUserRating:rating.user_rating * 20];        
    }

}

- (void)dealloc
{
    [outlineStarsView release];
    [redStarsView release];
    [yellowStarsView release];
    [ratingsLabel release];
    [super dealloc];
}

@end
