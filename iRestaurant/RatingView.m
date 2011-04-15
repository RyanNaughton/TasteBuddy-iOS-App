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
@synthesize allOutlineStarsView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithRating:(float)rating {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 20)];
    if (self) {
        // init code
        [self setupAllOutlineStarsView];
    }
    return self;
}

-(void) setupAllOutlineStarsView {
    for (int i=0; i < 5; i++) {
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * 20), 0, ((i + 1) * 20), 20)];
        outlineStar.image = [UIImage imageNamed:@"outline_star.png"];
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
    [super dealloc];
}

@end
