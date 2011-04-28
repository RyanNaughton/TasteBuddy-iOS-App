//
//  PhotoShareContainer.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "PhotoShareContainer.h"
#import "PhotoShareViewController.h"

@implementation PhotoShareContainer
@synthesize photoShareViewController, tableView, cancelButton, imageView, what, where, image, scrollView, whereTextField, whatTextField, commentsTextField, facebookSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (id)initWithWhere:(NSString *)where_passed andWhat:(NSString *)what_passed andImage:(UIImage *)image_passed {
    self = [super initWithNibName:@"PhotoShareContainer" bundle:nil];
    if (self) {
        //init
        what = what_passed;
        where = where_passed;
        image = image_passed;
        
           }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"hit");
    scrollView.frame = CGRectMake(0, 44, 320, 200);
    [scrollView scrollRectToVisible:textField.frame animated:NO];
}

-(IBAction) cancelButtonPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


- (void)dealloc
{
    [photoShareViewController release];
    [tableView release];
    [imageView release];
    [what release];
    [where release];
    [image release];
    [scrollView release];
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
    scrollView.contentSize = CGSizeMake(320, 261);
    tableView.scrollEnabled = FALSE;
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
