//
//  LoginViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "LoginViewController.h"
#import "iRestaurantAppDelegate.h"
#import "AbstractService.h"
#import "SignUpViewController.h"

@implementation LoginViewController

@synthesize username, password, cancelButton, loginButton, loginService, serviceToPerformSubsequentRequest, signUpButton, navItem;

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
    [signUpButton release];
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
    
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginLogo.png"]];
    appNameImageView.frame = CGRectMake(0, -3, 150, 44);
    appNameImageView.contentMode = UIViewContentModeRight;
    self.navItem.titleView = appNameImageView;
    
    UIImage *signUpBtnImage = [[UIImage imageNamed:@"orange-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    [signUpButton setBackgroundImage:signUpBtnImage forState:UIControlStateNormal];
    
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == password) {
        [textField resignFirstResponder];
        [self login];
    } else {
        [password becomeFirstResponder];
    }
    return NO;
}


-(IBAction) login {
    [loginService loginWith:username.text andPassword:password.text];
}

-(IBAction) signup {
    //iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    SignUpViewController *signUpVC = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    signUpVC.serviceToPerformSubsequentRequest = self.serviceToPerformSubsequentRequest;
    signUpVC.loginViewController = self;
    [self presentModalViewController:signUpVC animated:YES];
    
}

-(void) loginComplete:(AuthenticationResponse *)authToken
{
    [(iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate] updateAuthentication:authToken];
    if(serviceToPerformSubsequentRequest != nil) {
        [serviceToPerformSubsequentRequest logInFinished];        
    }
    [self cancel];
}

-(void) loginFailed {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log in error" message:@"Invalid Username or Password" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles: nil];
    [alert show];
    [alert release];
    [username becomeFirstResponder];
}

@end
