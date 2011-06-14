//
//  SearchSortAndFilterViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 31/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SearchSortAndFilterViewController.h"
#import "SearchViewController.h"
#import "SortAndFilterPreferences.h"
@implementation SearchSortAndFilterViewController

@synthesize sortControl, distanceControl, priceControl, svc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andSearchViewController:(SearchViewController *) searchViewController
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        svc = [searchViewController retain];
    }
    return self;
}

- (void)dealloc
{
    [svc release];
    [sortControl release];
    [distanceControl release];
    [priceControl release];
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
    // Do any additional setup after loading the view from its nib.
    sortControl.selectedSegmentIndex = svc.sortAndFilterPreferences.sortIndex;
    priceControl.selectedSegmentIndex = svc.sortAndFilterPreferences.priceIndex;
    distanceControl.selectedSegmentIndex = svc.sortAndFilterPreferences.distanceIndex;
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

-(IBAction) donePressed {
    SortAndFilterPreferences *pref = [[SortAndFilterPreferences alloc] init];
    pref.sortIndex = sortControl.selectedSegmentIndex;
    pref.priceIndex = priceControl.selectedSegmentIndex;
    pref.distanceIndex = distanceControl.selectedSegmentIndex;
    svc.sortAndFilterPreferences = [pref retain];
    [svc sortAndFilterRestaurantResults];
    [self cancelPressed];
}

-(IBAction) cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}
@end
