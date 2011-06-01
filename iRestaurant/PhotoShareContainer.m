//
//  PhotoShareContainer.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "PhotoShareContainer.h"
#import "PhotoUploadService.h"
#import "RestaurantViewController.h"
#import "DishViewController.h"
#import "SHK.h"
#import "SHKFacebook.h"
//#import "SHKTwitter.h"

@implementation PhotoShareContainer
@synthesize cancelButton, imageView, what, where, image, scrollView, whereTextField, whatTextField, commentsTextField, facebookSwitch, restaurant, menuItem, navItem, whereLabel, whatLabel, commentsLabel, submitButton, rvc, dvc, isForRestaurant, photoSubmitted;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (id)initWithWhere:(NSString *)where_passed andWhat:(NSString *)what_passed andImage:(UIImage *)image_passed andRestaurantId:(NSString *)restaurant_id_passed andMenuItemId:(NSString *) menu_item_id_passed{
    self = [super initWithNibName:@"PhotoShareContainer" bundle:nil];
    if (self) {
        //init
        what = what_passed;
        where = where_passed;
        image = image_passed;
        menuItem = menu_item_id_passed;
        restaurant = restaurant_id_passed;
           }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    scrollView.frame = CGRectMake(0, 44, 320, 200);
    [scrollView scrollRectToVisible:textField.frame animated:NO];
}

-(IBAction) cancelButtonPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction) submitButtonPressed:(id)sender 
{
    [self submitAction];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self submitAction];
    return YES;
}

-(void) submitAction {
    if (!photoSubmitted) {
        photoSubmitted = TRUE;
        submitButton.enabled = FALSE;
        cancelButton.enabled = FALSE;
        PhotoUploadService *photoUploadService = [[PhotoUploadService alloc]init];
        [photoUploadService uploadImage:image withWhere:whereTextField.text andWhat:whatTextField.text andComments:commentsTextField.text andFacebook:facebookSwitch.on andDelegate:self andRestaurantId:restaurant andMenuItemId:menuItem];
    } else {
        NSLog(@"ignore duplicate submission");
    }
}

-(void) imageLoadingDone:(NSDictionary *)dict {
    if (facebookSwitch.on) {
        [self shareOnFacebook];
    }
    if (isForRestaurant) {
        [rvc newImageLoaded:dict];
    } else {
        [dvc newImageLoaded:dict];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [what release];
    [where release];
    [image release];
    [menuItem release];
    //[restaurant release];
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
    
    whereTextField.placeholder = @"Restaurant Name";
    whatTextField.placeholder = @"Dish Name";
    
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"photoDetailsLogo.png"]];
    appNameImageView.frame = CGRectMake(0, -3, 175, 44);
    appNameImageView.contentMode = UIViewContentModeRight;
    navItem.titleView = appNameImageView;
    
    whereTextField.delegate = self;
    whatTextField.delegate = self;
    commentsTextField.delegate = self;
    
    whereTextField.text = [where retain];
    whatTextField.text = [what retain];
    
    if ([where length] > 0) {
        whereTextField.userInteractionEnabled = FALSE;
        whereTextField.textColor = [UIColor colorWithRed:89.0/255.0 green:149.0/255.0 blue:24.0/255.0 alpha:1.0];
    }
    if ([what length] > 0) {
        whatTextField.userInteractionEnabled = FALSE;
        whatTextField.textColor = [UIColor colorWithRed:89.0/255.0 green:149.0/255.0 blue:24.0/255.0 alpha:1.0];
    }
    
    if (([where length] > 0) && ([what length] > 0)) {
        [commentsTextField becomeFirstResponder];
    } else if ([where length] > 0) {
        //[whatTextField becomeFirstResponder];
        whatTextField.hidden = TRUE;
        whatLabel.hidden = TRUE;
        commentsTextField.frame = whatTextField.frame;
        commentsLabel.frame = whatLabel.frame;
    } else {
        [whereTextField becomeFirstResponder];
    }
    scrollView.contentSize = CGSizeMake(320, 261);
    imageView.image = image;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 70) ? NO : YES;
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

-(void) shareOnFacebook {
    NSMutableArray *titleForImage = [[NSMutableArray alloc] init];
    if(whatTextField.hidden){
        [titleForImage addObject:whereTextField.text];
    } else {
        if([whatTextField.text isEqualToString:@""]) {
            [titleForImage addObject:whereTextField.text];            
        } else {
            [titleForImage addObject:[NSString stringWithFormat:@"%@ @ %@", whatTextField.text, whereTextField.text]];
        }
    }
    if(![commentsTextField.text isEqualToString:@""]) {
        [titleForImage addObject:[NSString stringWithFormat:@"\"%@\"", commentsTextField.text]];
    }
    [titleForImage addObject:@"- shared from my TasteBuddy"];
    
    
    SHKItem *item = [SHKItem image:image title:[titleForImage componentsJoinedByString:@"\n"]];
    [SHKFacebook shareItem:item];
}

-(void) shareOnTwitter {
    //SHKItem *item = [SHKItem video:video title:@"I just used TasteBuddy for iPhone!"];
    //[SHKTwitter shareItem:item];
}

@end
