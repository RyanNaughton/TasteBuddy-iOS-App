//
//  UserSettingsViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "UserSettingsViewController.h"
#import "UserSettingsService.h"
#import "UserAttributesService.h"
#import "iRestaurantAppDelegate.h"
#import "ProfileTableViewController.h"

@implementation UserSettingsViewController

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
@synthesize uss, uas, ptvc;
@synthesize logoutButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setUserWithDictionary:(NSDictionary *)dict
{
    // setup textfields
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
    //[uss release];
    //[uas release];
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
    [self setTitle:@"Settings"];
    uss = [[UserSettingsService alloc]initWithDelegate:self];
    uas = [[UserAttributesService alloc]initWithDelegate:self];
    [uas getUserData];
    
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"settingsLogo.png"]];
    appNameImageView.frame = CGRectMake(0, -3, 150, 44);
    appNameImageView.contentMode = UIViewContentModeRight;
    self.navigationItem.titleView = appNameImageView;
    
    UIBarButtonItem *updateBtn = [[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(updateBtnPressed:)]; 
    self.navigationItem.rightBarButtonItem = updateBtn;
    [updateBtn release]; 
    
    UIImage *logoutButtonImage = [[UIImage imageNamed:@"red-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    [logoutButton setBackgroundImage:logoutButtonImage forState:UIControlStateNormal];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    scrollView.contentSize = CGSizeMake(320, 430);

    
    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardDidShow:(NSNotification *)notification {
    scrollView.contentSize = CGSizeMake(320, 380);
    scrollView.frame = CGRectMake(0, 0, 320, 200);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int maxLength = 999;
    if ((textField == birthdayMonthField) || (textField == birthdayDayField)) { maxLength = 2; }
    if (textField == birthdayYearField) { maxLength = 4; }
    if (textField == postalCodeField) { maxLength = 5; }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > maxLength) ? NO : YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == birthdayYearField) {
        [birthdayYearField resignFirstResponder];
        [self updateBtnPressed:nil];
    } else if(textField == usernameField ){
        [firstNameField becomeFirstResponder];
    } else if(textField == firstNameField) {
        [lastNameField becomeFirstResponder];
    } else if(textField == lastNameField) {
        [passwordField becomeFirstResponder];
    } else if(textField == passwordField) {
        [confirmPasswordField becomeFirstResponder];
    } else if(textField == confirmPasswordField) {
        [postalCodeField becomeFirstResponder];
    } else if(textField == postalCodeField) {
        [emailField becomeFirstResponder];
    } else if(textField == emailField) {
        [birthdayMonthField becomeFirstResponder];
    } else if(textField == birthdayMonthField) {
        [birthdayDayField becomeFirstResponder];
    } else if(textField == birthdayDayField) {
        [birthdayYearField becomeFirstResponder];
    }
    return NO;
}

-(void)updateBtnPressed:(id)sender {
    NSString *dateRegex = @"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$";

    if([birthdayDayField.text length] ==1) {
        birthdayDayField.text = [NSString stringWithFormat:@"0%@",birthdayDayField.text];
    }

    if([birthdayMonthField.text length] ==1) {
      birthdayMonthField.text = [NSString stringWithFormat:@"0%@",birthdayMonthField.text];
    }

                                 
    NSString *birthdayString = [NSString stringWithFormat:@"%@-%@-%@", birthdayYearField.text, birthdayMonthField.text, birthdayDayField.text];
    
    NSPredicate* dateTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", dateRegex]; 

    if(![dateTest evaluateWithObject:birthdayString]) {
        birthdayDayField.text = @"";
        birthdayMonthField.text = @"";
        birthdayYearField.text = @"";
        birthdayString = @"--";
    }
    
    [uss updateWithUsername:usernameField.text 
               andFirstName:firstNameField.text 
                andLastName:lastNameField.text 
                andPassword:passwordField.text 
               andConfirmPW:confirmPasswordField.text 
                 andCountry:countryField.text 
              andPostalCode:postalCodeField.text 
                   andEmail:emailField.text 
               andBirthdate:birthdayString];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startLoadingIndicator" object:nil];
}

-(void) settingsUpdateComplete:(AuthenticationResponse *)authToken {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"SUCCESS!" message:@"You have successfully updated your TasteBuddy profile!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void) attributesServiceComplete:(NSDictionary *)dict {
    countryField.text = [dict objectForKey:@"country"];
    emailField.text = [dict objectForKey:@"email"];
    firstNameField.text = [dict objectForKey:@"first_name"];
    lastNameField.text = [dict objectForKey:@"last_name"];
    postalCodeField.text = [dict objectForKey:@"postal_code"];
    usernameField.text = [dict objectForKey:@"username"];
    
    NSString *birthdayString = [dict objectForKey:@"birthday"];
    
    if (![birthdayString isKindOfClass:[NSNull class]]) {
    
    NSArray *birthdayNumbersArray = [birthdayString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
    
    birthdayYearField.text = (NSString *)[birthdayNumbersArray objectAtIndex:0];
    birthdayMonthField.text = (NSString *)[birthdayNumbersArray objectAtIndex:1];
    
    // WORKAROUND FOR EXTRA STRING AT END OF BIRTHDAY DAY
    NSString *birthdayDayMessy = (NSString *)[birthdayNumbersArray objectAtIndex:2];
    NSArray *birthdayDayArray = [birthdayDayMessy componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"T"]];
    birthdayDayField.text = (NSString *)[birthdayDayArray objectAtIndex:0];
        
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

-(IBAction)logout {
    UIAlertView *areYouSureAlert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [areYouSureAlert show];
    [areYouSureAlert release];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate logout];
        
        [self.navigationController popViewControllerAnimated:NO];
        ptvc.dataReceived = FALSE;
        [ptvc checkLogin];
        [ptvc.tableView reloadData];
    }
}
-(void) settingsUpdateComplete {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stopLoadingIndicator" object:nil];
    UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Update Profile" message:@"Your TasteBuddy Profile has been Updated." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [updateComplete show];
    [updateComplete release];
   
}

@end
