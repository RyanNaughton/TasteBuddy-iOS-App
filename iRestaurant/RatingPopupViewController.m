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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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
    
    UIImage *signUpBtnImage = [[UIImage imageNamed:@"orange-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    [submitButton setBackgroundImage:signUpBtnImage forState:UIControlStateNormal];
    
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
