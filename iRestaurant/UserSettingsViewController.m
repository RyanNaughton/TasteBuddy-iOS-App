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
@synthesize uss, uas;

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
    
    //[usernameField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    scrollView.contentSize = CGSizeMake(320, 346);

    
    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardDidShow:(NSNotification *)notification {
    scrollView.frame = CGRectMake(0, 0, 320, 200);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"shouldChangeCharactersInRange");
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
    NSString *birthdayString = [NSString stringWithFormat:@"%@-%@-%@", birthdayYearField.text, birthdayMonthField.text, birthdayDayField.text];
    
    [uss updateWithUsername:usernameField.text 
               andFirstName:firstNameField.text 
                andLastName:lastNameField.text 
                andPassword:passwordField.text 
               andConfirmPW:confirmPasswordField.text 
                 andCountry:countryField.text 
              andPostalCode:postalCodeField.text 
                   andEmail:emailField.text 
               andBirthdate:birthdayString];
}

-(void) settingsUpdateComplete:(AuthenticationResponse *)authToken {
    NSLog(@"settings update complete: %@", authToken);
}

-(void) attributesServiceComplete:(NSDictionary *)dict {
    NSLog(@"dict returned: %@", dict);

    countryField.text = [dict objectForKey:@"country"];
    emailField.text = [dict objectForKey:@"email"];
    firstNameField.text = [dict objectForKey:@"first_name"];
    lastNameField.text = [dict objectForKey:@"last_name"];
    postalCodeField.text = [dict objectForKey:@"postal_code"];
    usernameField.text = [dict objectForKey:@"username"];
    
    NSString *birthdayString = [dict objectForKey:@"birthday"];
    NSArray *birthdayNumbersArray = [birthdayString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
    
    birthdayYearField.text = (NSString *)[birthdayNumbersArray objectAtIndex:0];
    birthdayMonthField.text = (NSString *)[birthdayNumbersArray objectAtIndex:1];
    
    // WORKAROUND FOR EXTRA STRING AT END OF BIRTHDAY DAY
    NSString *birthdayDayMessy = (NSString *)[birthdayNumbersArray objectAtIndex:2];
    NSArray *birthdayDayArray = [birthdayDayMessy componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"T"]];
    birthdayDayField.text = (NSString *)[birthdayDayArray objectAtIndex:0];
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
