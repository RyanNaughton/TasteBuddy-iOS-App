//
//  RatingPopupViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/16/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RatingPopupViewController.h"


@implementation RatingPopupViewController

@synthesize closeButton, submitButton;
@synthesize star1;
@synthesize star2;
@synthesize star3;
@synthesize star4;
@synthesize star5;
@synthesize starsArray;
@synthesize currentRating;
@synthesize orangeStar, whiteStar;
@synthesize delegate;
@synthesize commentField, commentBoxBG;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCurrentRating:(float)rating {
    self = [super initWithNibName:@"RatingPopupViewController" bundle:nil];
    if (self) {
        // Custom initialization
        currentRating = rating;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    return (newLength > 140) ? NO : YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"Share your thoughts! (optional)"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(IBAction)closeButtonPressed:(id)sender 
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.333];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.alpha = 0.0;
    [UIView setAnimationDidStopSelector:@selector(closeAnimationFinished)];
    [UIView commitAnimations];
}

-(void) closeAnimationFinished {
    [self.view removeFromSuperview];
}

-(IBAction)submitButtonPressed:(id)sender 
{
    if ([commentField.text isEqualToString:@"Share your thoughts! (optional)"]) {
        commentField.text = @"";
    }
    
    [delegate startRatingServiceWithRating:currentRating andComments:commentField.text];
    commentField.text = @"";
    [self closeButtonPressed:nil];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    orangeStar = [UIImage imageNamed:@"big-star-orange.png"];
    whiteStar = [UIImage imageNamed:@"big-star-white.png"];
    
    UIImage *signUpBtnImage = [[UIImage imageNamed:@"orange-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    [submitButton setBackgroundImage:signUpBtnImage forState:UIControlStateNormal];
    
    starsArray = [[NSArray alloc]initWithObjects:star1, star2, star3, star4, star5, nil];
    [self updateStarImages];
    
    UIImage *textBox = [[UIImage imageNamed:@"text-area-image.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    commentBoxBG.image = textBox;
    
}

-(void) animateIn {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.333];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.alpha = 1.0;
    //[UIView setAnimationDidStopSelector:@selector(matchAnimation2)];
    [UIView commitAnimations];
}

-(IBAction) starTouchStarted:(id)sender {
    UIButton *currentButton = (UIButton *)sender;
    currentRating = [starsArray indexOfObject:currentButton] + 1;
    [self updateStarImages];
}

-(IBAction) starTouchContinued:(id)sender
{
    UIButton *currentButton = (UIButton *)sender;
    currentRating = [starsArray indexOfObject:currentButton] + 1;
    [self updateStarImages];
}

-(IBAction) starTouchEnded:(id)sender
{
    UIButton *currentButton = (UIButton *)sender;
    currentRating = [starsArray indexOfObject:currentButton] + 1;
    currentButton.exclusiveTouch = FALSE;
    [self updateStarImages];
}

-(void)updateStarImages {
    
    for (int i = 0; i < currentRating; i++) {
        UIButton *starToUpdate = (UIButton *)[starsArray objectAtIndex:i];
        [starToUpdate setImage:orangeStar forState:UIControlStateNormal];
    }

    for (int i = 4; i > (currentRating - 1); i--) {
        UIButton *starToUpdate = (UIButton *)[starsArray objectAtIndex:i];
        [starToUpdate setImage:whiteStar forState:UIControlStateNormal];
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
