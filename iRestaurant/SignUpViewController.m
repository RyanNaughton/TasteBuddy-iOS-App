//
//  SignUpViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/11/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SignUpViewController.h"


@implementation SignUpViewController

@synthesize scrollView;
@synthesize usernameField;
@synthesize firstNameField;
@synthesize lastNameField;
@synthesize passwordField;
@synthesize confirmPasswordField;
@synthesize countryField;
@synthesize postalCodeField;
@synthesize emailField;
@synthesize birthdayMonthField;
@synthesize birthdayDayField;
@synthesize birthdayYearField;

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
    [scrollView           release];
    [usernameField        release];
    [firstNameField       release];
    [lastNameField        release];
    [passwordField        release];
    [confirmPasswordField release];
    [countryField         release];
    [postalCodeField      release];
    [emailField           release];
    [birthdayMonthField   release];
    [birthdayDayField     release];
    [birthdayYearField    release];
    [super dealloc];
}

-(IBAction)cancelButtonPressed;
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)sendButtonPressed 
{
    NSLog(@"send");
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    scrollView.contentSize = CGSizeMake(320, 346);
    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardDidShow:(NSNotification *)notification {
    scrollView.frame = CGRectMake(0, 44, 320, 200);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //scrollView.frame = CGRectMake(0, 44, 320, 200);
    //[scrollView scrollRectToVisible:textField.frame animated:YES];
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
