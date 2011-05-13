//
//  SignUpViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/11/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCreationService.h"
@class AuthenticationResponse;
@class UserCreationService;
@class LoginViewController;

@interface SignUpViewController : UIViewController <UITextFieldDelegate, UserCreationServiceDelegate> {
	IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *firstNameField;
    IBOutlet UITextField *lastNameField;
    IBOutlet UITextField *passwordField;
    IBOutlet UITextField *confirmPasswordField;
    IBOutlet UITextField *countryField;
    IBOutlet UITextField *postalCodeField;
    IBOutlet UITextField *emailField;
    IBOutlet UITextField *birthdayMonthField;
    IBOutlet UITextField *birthdayDayField;
    IBOutlet UITextField *birthdayYearField;
    UserCreationService *ucs;
    LoginViewController *loginViewController;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *firstNameField;
@property (nonatomic, retain) IBOutlet UITextField *lastNameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UITextField *confirmPasswordField;
@property (nonatomic, retain) IBOutlet UITextField *countryField;
@property (nonatomic, retain) IBOutlet UITextField *postalCodeField;
@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *birthdayMonthField;
@property (nonatomic, retain) IBOutlet UITextField *birthdayDayField;
@property (nonatomic, retain) IBOutlet UITextField *birthdayYearField;
@property (nonatomic, retain) UserCreationService *ucs;
@property (nonatomic, retain) LoginViewController *loginViewController;

-(IBAction)cancelButtonPressed;
-(IBAction)sendButtonPressed;
- (void)keyboardDidShow:(NSNotification *)notification;

-(void) signupComplete:(AuthenticationResponse *)authToken;

@end
