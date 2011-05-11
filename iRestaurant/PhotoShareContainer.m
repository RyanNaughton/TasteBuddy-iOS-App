//
//  PhotoShareContainer.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "PhotoShareContainer.h"
#import "PhotoUploadService.h"

@implementation PhotoShareContainer
@synthesize cancelButton, imageView, what, where, image, scrollView, whereTextField, whatTextField, commentsTextField, facebookSwitch, restaurant, menuItem;

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
    PhotoUploadService *photoUploadService = [[PhotoUploadService alloc]init];
    [photoUploadService uploadImage:image withWhere:whereTextField.text andWhat:whatTextField.text andComments:commentsTextField.text andFacebook:facebookSwitch.on andDelegate:self andRestaurantId:restaurant andMenuItemId:menuItem];
}

-(void) imageLoadingDone {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [what release];
    [where release];
    [image release];
    [menuItem release];
    [restaurant release];
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
    
    whereTextField.delegate = self;
    whatTextField.delegate = self;
    commentsTextField.delegate = self;
    
    whereTextField.text = where;
    whatTextField.text = what;
    
    
    scrollView.contentSize = CGSizeMake(320, 261);
    imageView.image = image;

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
