//
//  RatingPopupViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/16/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RatingPopupDelegate <NSObject>
-(void)startRatingServiceWithRating:(float)rating andComments:(NSString *)comments;
@end


@interface RatingPopupViewController : UIViewController <UITextFieldDelegate> {
    id <RatingPopupDelegate> delegate;
    IBOutlet UIButton *closeButton; 
    IBOutlet UIButton *submitButton; 
    IBOutlet UIButton *star1;
    IBOutlet UIButton *star2;
    IBOutlet UIButton *star3;
    IBOutlet UIButton *star4;
    IBOutlet UIButton *star5;
    IBOutlet UITextField *commentField;
    NSArray *starsArray;
    int currentRating;
    UIImage *orangeStar;
    UIImage *whiteStar;
}

@property (nonatomic, retain) IBOutlet UIButton *closeButton;
@property (nonatomic, retain) IBOutlet UIButton *submitButton;
@property (nonatomic, retain) IBOutlet UIButton *star1;
@property (nonatomic, retain) IBOutlet UIButton *star2;
@property (nonatomic, retain) IBOutlet UIButton *star3;
@property (nonatomic, retain) IBOutlet UIButton *star4;
@property (nonatomic, retain) IBOutlet UIButton *star5;
@property (nonatomic, retain) IBOutlet UITextField *commentField;
@property (nonatomic, retain) NSArray *starsArray;
@property (nonatomic, assign) int currentRating;
@property (nonatomic, retain) UIImage *orangeStar;
@property (nonatomic, retain) UIImage *whiteStar;
@property (nonatomic, retain) id <RatingPopupDelegate> delegate;

-(id)initWithCurrentRating:(float)rating;

-(IBAction)closeButtonPressed:(id)sender;
-(IBAction)submitButtonPressed:(id)sender;
-(void) closeAnimationFinished;
-(void) updateStarImages;
-(void) animateIn;
-(IBAction) starTouchStarted:(id)sender;
-(IBAction) starTouchEnded:(id)sender;
-(IBAction) starTouchContinued:(id)sender;

@end
