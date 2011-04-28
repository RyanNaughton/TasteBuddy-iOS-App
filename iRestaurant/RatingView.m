//
//  RatingView.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//
// 100 x 20 pixels

#import "RatingView.h"
#import "iRestaurantAppDelegate.h"

@implementation RatingView
@synthesize outlineStarsView, redStarsView, yellowStarsView, ratingButton, starSize;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithRating:(float)rating andStarSize:(int)starSize_passed andIsUserRating:(BOOL)isUserRating andIsEditable:(BOOL)isEditable {
    self = [super initWithFrame:CGRectMake(0, 0, 100, starSize)];
    if (self) {
        // init code
        starSize = starSize_passed;
        [self setupOutlineStarsView];
        if (rating > 0) {
            if (isUserRating) {
                [self setupYellowStarsView];
                yellowStarsView.frame = CGRectMake(0, 0, ((rating * (starSize *5)) / 100), starSize);
                yellowStarsView.clipsToBounds = TRUE;
            } else {
                [self setupRedStarsView];
                redStarsView.frame = CGRectMake(0, 0, ((rating * (starSize *5)) / 100), starSize);
                redStarsView.clipsToBounds = TRUE;
            }
        }
        if (isEditable) { [self setupRatingButton]; }
    }
    return self;
}

-(id)initWithRating:(float)rating andHowManyRatings:(int)howManyRatings andStarSize:(int)starSize_passed andIsUserRating:(BOOL)isUserRating andIsEditable:(BOOL)isEditable {
    self = [super initWithFrame:CGRectMake(0, 0, (((rating * (starSize_passed *5)) / 100) + 50), starSize_passed)];
    if (self) {
        // init code
        starSize = starSize_passed;
        [self setupOutlineStarsView];
        if (rating > 0) {
            if (isUserRating) {
                [self setupYellowStarsView];
                yellowStarsView.frame = CGRectMake(0, 0, ((rating * (starSize *5)) / 100), starSize);
                yellowStarsView.clipsToBounds = TRUE;
            } else {
                [self setupRedStarsView];
                redStarsView.frame = CGRectMake(0, 0, ((rating * (starSize *5)) / 100), starSize);
                redStarsView.clipsToBounds = TRUE;
            }
        }
        if (howManyRatings) { [self setupRatingCount:howManyRatings]; }
        if (isEditable) { [self setupRatingButton]; }
    }
    return self;
}


// sets user rating to a float passed in. rating is a % (rating/100)
-(void) setUserRating:(float)rating {
    
    for (UIView *view in self.subviews) {
        if (view == redStarsView) {
            [redStarsView removeFromSuperview];
        }
        if (view == yellowStarsView) {
            [yellowStarsView removeFromSuperview];
        }
    }
    [self setupYellowStarsView];
    yellowStarsView.frame = CGRectMake(0, 0, ((rating * (starSize *5)) / 100), starSize);
    yellowStarsView.clipsToBounds = TRUE;
    [self bringSubviewToFront:ratingButton];
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
    [self addSubview:outlineStarsView];
    [outlineStarsView release];
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
    [redStarsView release];
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
    [yellowStarsView release];
}

-(void)setupRatingButton {
    ratingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ratingButton.frame = CGRectMake(0, 0, (starSize * 5), starSize);
    ratingButton.backgroundColor = [UIColor clearColor];
    [ratingButton addTarget:self action:@selector(rate:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ratingButton];
}

-(void)setupRatingCount:(int)howManyRatings {
    UILabel *ratingsLabel = [[UILabel alloc]initWithFrame:CGRectMake (((starSize * 5) + 5), 2, 100, starSize)];
    ratingsLabel.text = [NSString stringWithFormat:@"%i ratings", howManyRatings];
    ratingsLabel.textColor = [UIColor darkGrayColor];
    ratingsLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:ratingsLabel];
    [ratingsLabel release];
}

-(void)rate:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"★★★★★", @"★★★★", @"★★★", @"★★", @"★", nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
//    CGRect pickerFrame = CGRectMake(0, 0, 320, 100);
//    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
//    pickerView.showsSelectionIndicator = YES;
//    pickerView.dataSource = self;
//    pickerView.delegate = self;
//    [actionSheet addSubview:pickerView];
//    [pickerView release];
    
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];

    
    [actionSheet showInView:appDelegate.tabBarController.view];
    [actionSheet release];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) // 5 stars
    {
        [self setUserRating:100.0];
    }
    if (buttonIndex == 1) // 4 stars
    {
        [self setUserRating:80.0];
    }
    if (buttonIndex == 2) // 3 stars
    {
        [self setUserRating:60.0];
    }
    if (buttonIndex == 3) // 2 stars
    {
        [self setUserRating:40.0];
    }
    if (buttonIndex == 4) // 1 stars
    {
        [self setUserRating:20.0];
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
