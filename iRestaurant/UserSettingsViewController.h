//
//  UserSettingsViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSettingsService.h"
#import "UserAttributesService.h"
@class ProfileTableViewController;

@interface UserSettingsViewController : UIViewController <UITextFieldDelegate, UserSettingsServiceDelegate, UserAttributesServiceDelegate, UIAlertViewDelegate> {
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
    UserSettingsService *uss;
    UserAttributesService *uas;
    ProfileTableViewController *ptvc;
    IBOutlet UIButton *logoutButton;
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
@property (nonatomic, retain) UserSettingsService *uss;
@property (nonatomic, retain) UserAttributesService *uas;
@property (nonatomic, retain) ProfileTableViewController *ptvc;
@property (nonatomic, retain) IBOutlet UIButton *logoutButton;

-(void)setUserWithDictionary:(NSDictionary *)dict;

-(void)updateBtnPressed:(id)sender;
-(void)keyboardDidShow:(NSNotification *)notification;

-(void) settingsUpdateComplete:(AuthenticationResponse *)authToken;
-(void) attributesServiceComplete:(NSDictionary *)dict;
-(IBAction)logout;

@end
