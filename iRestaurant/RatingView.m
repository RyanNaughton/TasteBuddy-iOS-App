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
@synthesize outlineStarsView, redStarsView, yellowStarsView, ratingButton;

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
                NSLog(@"red stars!");
                [self setupRedStarsView];
                redStarsView.frame = CGRectMake(0, 0, rating, 20);
                redStarsView.clipsToBounds = TRUE;
            }
        }
        [self setupRatingButton];
    }
    return self;
}

-(void) setUserRating:(float)rating {
    
    for (UIView *view in self.subviews) {
        if (view == redStarsView) {
            [redStarsView removeFromSuperview];
        }
        if (view == yellowStarsView) {
            [yellowStarsView removeFromSuperview];
        }
    }
    NSLog(@"rating is: %g", rating);
    [self setupYellowStarsView];
    yellowStarsView.frame = CGRectMake(0, 0, rating, 20);
    yellowStarsView.clipsToBounds = TRUE;
    [self bringSubviewToFront:ratingButton];
}

-(void) setupOutlineStarsView {
    outlineStarsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    for (int i=0; i < 5; i++) {
        NSLog(@"add outline star");
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * 20), 0, 20, 20)];
        outlineStar.image = [UIImage imageNamed:@"outline_star.png"];
        outlineStar.contentMode = UIViewContentModeScaleToFill;
        [outlineStarsView addSubview:outlineStar];
        [outlineStar release];
    }
    [self addSubview:outlineStarsView];
}

-(void) setupRedStarsView {
    redStarsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    for (int i=0; i < 5; i++) {
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * 20), 0, 20, 20)];
        outlineStar.image = [UIImage imageNamed:@"red_star.png"];
        outlineStar.contentMode = UIViewContentModeScaleToFill;
        [redStarsView addSubview:outlineStar];
        [outlineStar release];
    }
    [self addSubview:redStarsView];
    
}

-(void) setupYellowStarsView {
    yellowStarsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    for (int i=0; i < 5; i++) {
        UIImageView *outlineStar = [[UIImageView alloc]initWithFrame:CGRectMake((i * 20), 0, 20, 20)];
        outlineStar.image = [UIImage imageNamed:@"yellow_star.png"];
        outlineStar.contentMode = UIViewContentModeScaleToFill;
        [yellowStarsView addSubview:outlineStar];
        [outlineStar release];
    }
    [self addSubview:yellowStarsView];
}

-(void)setupRatingButton {
    ratingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ratingButton.frame = CGRectMake(0, 0, 100, 20);
    ratingButton.backgroundColor = [UIColor clearColor];
    [ratingButton addTarget:self action:@selector(rate:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ratingButton];
}

-(void)rate:(id)sender {
    NSLog(@"rate");
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
    NSLog(@"index; %i", buttonIndex);
    
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
    //[ratingButton release];
    [outlineStarsView release];
    [redStarsView release];
    [yellowStarsView release];
    [super dealloc];
}

@end