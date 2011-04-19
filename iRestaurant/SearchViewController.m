//
//  SearchViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchService.h"
#import "RestaurantSearchResultTableViewController.h"
#import "DishSearchResultTableViewController.h"
#import "ASIFormDataRequest.h"
#import "FindAutocompleteTableViewController.h"
#import "NearAutocompleteTableViewController.h"
#import "AutocompleteService.h"

@implementation SearchViewController

@synthesize searchService, autocompleteService;
@synthesize restaurantSearchResultTableViewController, dishSearchResultTableViewController;
@synthesize tableView;
@synthesize searchView;
@synthesize nearField;
@synthesize termField;
@synthesize showSearchButton;
@synthesize searchViewControl;
@synthesize findAutocompleteTableViewController, nearAutocompleteTableViewController;
@synthesize restaurantsTabButton, dishesTabButton;


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
    [searchService release];
    [restaurantSearchResultTableViewController release];
    [dishSearchResultTableViewController release];
    [tableView release];
    [searchView release];
    [nearField release];
    [termField release];
    [findAutocompleteTableViewController release];
    [nearAutocompleteTableViewController release];
    [showSearchButton release];
    [searchViewControl release];
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
    
    restaurantsTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [restaurantsTabButton setTitle:@"Restaurants" forState:UIControlStateNormal];
    restaurantsTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [restaurantsTabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    restaurantsTabButton.frame =  CGRectMake(0, 4, 80, 35);
    [restaurantsTabButton setBackgroundImage:[[UIImage imageNamed:@"grey-tab.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    
    dishesTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dishesTabButton setTitle:@"Dishes" forState:UIControlStateNormal];
    dishesTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    dishesTabButton.frame =  CGRectMake(80, 4, 80, 35);
    [dishesTabButton setBackgroundImage:[[UIImage imageNamed:NULL] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    
    UIView *tabView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [tabView addSubview:restaurantsTabButton];
    [tabView addSubview:dishesTabButton];
    self.navigationItem.titleView = tabView;
    
    
    
    UIImageView *searchViewBGImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search-text-bg.png"]];
    [searchView addSubview:searchViewBGImage];
    [searchView sendSubviewToBack:searchViewBGImage];
    
    [self searchViewAnimateIn];
    // Do any additional setup after loading the view from its nib.    
    CGPoint point = CGPointMake(1.2345, 1.2345);
    searchService = [[SearchService alloc]initWithLocation:point withDelegate:self];
    autocompleteService = [[AutocompleteService alloc] initWithDelegate: findAutocompleteTableViewController];
    
    showSearchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchViewAnimateIn)];
   // self.navigationItem.rightBarButtonItem = showSearchButton;
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

-(IBAction) switchSearchView:(id) sender
{
    switch (searchViewControl.selectedSegmentIndex) {
        case 0: //Restaurant
            tableView.delegate = restaurantSearchResultTableViewController;
            tableView.dataSource = restaurantSearchResultTableViewController;
            [tableView reloadData];
            tableView.hidden = false;
            break;
        case 1: //Dishes
            tableView.delegate = dishSearchResultTableViewController;
            tableView.dataSource = dishSearchResultTableViewController;
            [tableView reloadData];
            tableView.hidden = false;
            break;
        case 2: //Map
            tableView.hidden = true;
            break;
        default:
            break;
    }   
    [tableView setContentOffset:CGPointMake(0, 0) animated:NO];

    //Need to scroll to top here
}

-(void)searchFinished:(NSMutableArray *)restaurantsArray 
{ 
    restaurantSearchResultTableViewController.restaurantsArray = [restaurantsArray retain];
    dishSearchResultTableViewController.restaurantsArray = [restaurantsArray retain];
    [self resultsLoaded];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [searchService searchByTerm:termField.text andNear:nearField.text];
    [self switchSearchView:(id) searchViewControl];
    [self resultsLoading];
    [self searchViewAnimateOut];
    return NO;
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
    self.navigationItem.rightBarButtonItem = nil;
    [termField becomeFirstResponder];
    [self autocomplete:termField]; //Force the appropriate TableView to kick in
    searchView.center = CGPointMake(searchView.center.x, searchView.frame.size.height / 2 * -1);
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height - 44);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];

    searchView.center = CGPointMake(searchView.center.x, searchView.frame.size.height / 2 );
    tableView.frame = CGRectMake(0, searchView.frame.size.height, self.view.frame.size.width,  self.view.frame.size.height -  (220 + 22));
    [UIView commitAnimations];
}

-(void) searchViewAnimateOut
{   
    self.navigationItem.rightBarButtonItem = showSearchButton;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    searchView.center = CGPointMake(searchView.center.x, searchView.frame.size.height / 2 * -1);
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height - 44);
    [UIView commitAnimations];
}

-(void) resultsLoading
{
    restaurantSearchResultTableViewController.isLoading = YES;
    dishSearchResultTableViewController.isLoading = YES;
    [tableView reloadData];
}

-(void) resultsLoaded
{
    restaurantSearchResultTableViewController.isLoading = NO;
    dishSearchResultTableViewController.isLoading = NO;
    [tableView reloadData];
}

@end
