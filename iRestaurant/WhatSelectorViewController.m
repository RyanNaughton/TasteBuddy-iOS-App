//
//  WhatSelectorViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 6/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "WhatSelectorViewController.h"
#import "WhatSelectorTableViewController.h"

@implementation WhatSelectorViewController
@synthesize whatSelectorTableViewController, delegate, restaurant;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRestaurant:(Restaurant *)restaurant_passed
{
    self = [super initWithNibName:@"WhatSelectorViewController" bundle:nil];
    if (self) {
        // Custom initialization
        restaurant = [restaurant_passed retain];
    }
    return self;
}

- (void)dealloc
{
    [restaurant release];
    [whatSelectorTableViewController release];
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
    whatSelectorTableViewController.delegate = self.delegate;
    whatSelectorTableViewController.restaurant = self.restaurant;
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
