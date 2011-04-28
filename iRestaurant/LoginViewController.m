//
//  LoginViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "LoginViewController.h"
#import "iRestaurantAppDelegate.h"
@implementation LoginViewController

@synthesize username, password, cancelButton, loginButton, loginService;

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
    [loginService release];
    [cancelButton release];
    [loginButton release];
    [username release];
    [password release];
    [super dealloc];
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
    // Do any additional setup after loading the view from its nib.
    loginService = [[LoginService alloc] initWithDelegate:self];
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

-(IBAction) cancel {
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction) login {
    [loginService loginWith:username.text andPassword:password.text];
}

-(void) loginComplete:(AuthenticationResponse *)authToken
{
    [(iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate] updateAuthentication:authToken]; 
    [self cancel];
}
@end
