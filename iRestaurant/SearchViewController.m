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

    //Need to scroll to top here
}

-(void)searchFinished:(NSMutableArray *)restaurantsArray 
{ 
    restaurantSearchResultTableViewController.restaurantsArray = [restaurantsArray retain];
    dishSearchResultTableViewController.restaurantsArray = [restaurantsArray retain];
    [tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [searchService searchByTerm:termField.text andNear:nearField.text];
    [self switchSearchView:(id) searchViewControl];
    [self searchViewAnimateOut];
    return NO;
}

-(IBAction) autocomplete:(id) sender
{
    if ([((UITextField *) sender).text length] > 2) {
        if((UITextField *) sender == termField) {
            tableView.delegate = findAutocompleteTableViewController;
            tableView.dataSource = findAutocompleteTableViewController;
            autocompleteService.delegate = findAutocompleteTableViewController;
            findAutocompleteTableViewController.tableView = self.tableView;
            [autocompleteService getTerms:termField.text];
        
        } else {
            tableView.delegate = nearAutocompleteTableViewController;
            tableView.dataSource = nearAutocompleteTableViewController;
            autocompleteService.delegate = nearAutocompleteTableViewController;
            nearAutocompleteTableViewController.tableView = self.tableView;
            [autocompleteService getPlaces:nearField.text];
        }
    }
}

-(void) searchViewAnimateIn 
{
    tableView.hidden = NO;
    self.navigationItem.rightBarButtonItem = nil;
    [termField becomeFirstResponder];
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

@end
