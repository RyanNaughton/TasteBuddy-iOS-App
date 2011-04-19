//
//  AutocompleteModalViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 19/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "AutocompleteModalViewController.h"
#import "FindAutocompleteTableViewController.h"
#import "NearAutocompleteTableViewController.h"
#import "SearchViewController.h"

@implementation AutocompleteModalViewController

@synthesize tableView, searchView, termField, nearField, findAutocompleteTableViewController, nearAutocompleteTableViewController, autocompleteService, searchViewController;

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
    [tableView release];
    [searchView release];
    [termField release];
    [nearField release];
    [findAutocompleteTableViewController release];
    [nearAutocompleteTableViewController release];
    [autocompleteService release];
    [searchViewController release];
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
    autocompleteService = [[AutocompleteService alloc] initWithDelegate: findAutocompleteTableViewController];
    [self searchViewAnimateIn];
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

-(IBAction) autocomplete:(id) sender
{
    //Need this for setting the autocomplete to show on searchViewAnimateIn
    if((UITextField *) sender == termField) {
        tableView.delegate = findAutocompleteTableViewController;
        tableView.dataSource = findAutocompleteTableViewController;
        autocompleteService.delegate = findAutocompleteTableViewController;
        findAutocompleteTableViewController.tableView = self.tableView;
    } else {
        tableView.delegate = nearAutocompleteTableViewController;
        tableView.dataSource = nearAutocompleteTableViewController;
        autocompleteService.delegate = nearAutocompleteTableViewController;
        nearAutocompleteTableViewController.tableView = self.tableView;
    }
    
    [tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    //Only trigger service call when term length is long enough
    if ([((UITextField *) sender).text length] > 2) {
        if((UITextField *) sender == termField) {
            [autocompleteService getTerms:termField.text];
        } else {
            [autocompleteService getPlaces:nearField.text];
        }
    }
}

-(void) searchViewAnimateIn 
{
    tableView.hidden = NO; //Show if in Map view
    [termField becomeFirstResponder];
    [self autocomplete:termField]; //Force the appropriate TableView to kick in
    searchView.center = CGPointMake(searchView.center.x, searchView.frame.size.height / 2 * -1);
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    searchView.center = CGPointMake(searchView.center.x, searchView.frame.size.height / 2 );
    tableView.frame = CGRectMake(0, searchView.frame.size.height, self.view.frame.size.width,  self.view.frame.size.height -  (220 + 22));
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [searchViewController.searchService searchByTerm:termField.text andNear:nearField.text];
    [searchViewController switchSearchView:(id) searchViewController.searchViewControl];
    [searchViewController resultsLoading];
    [self dismissModalViewControllerAnimated:YES];
    return NO;
}


@end