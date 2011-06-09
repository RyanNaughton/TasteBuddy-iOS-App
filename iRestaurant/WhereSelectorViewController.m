//
//  WhereSelectorViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 6/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "WhereSelectorViewController.h"
#import "WhereSelectorTableViewController.h"
#import "SearchService.h"
#import "ASIFormDataRequest.h"

@implementation WhereSelectorViewController
@synthesize whereSelectorTableViewController, delegate;

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
    [whereSelectorTableViewController release];
    [super dealloc];
}

-(IBAction)cancelButtonPressed
{
    if (whereSelectorTableViewController.ss.request != nil) {
        [whereSelectorTableViewController.ss.request cancel];
    }

    [self dismissModalViewControllerAnimated:YES];
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
    whereSelectorTableViewController.delegate = self.delegate;
    // Do any additional setup after loading the view from its nib.
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
