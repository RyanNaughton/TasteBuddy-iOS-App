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

@implementation SearchViewController

@synthesize searchService;
@synthesize restaurantSearchResultTableViewController, dishSearchResultTableViewController;
@synthesize tableView, searchBar;

@synthesize searchView;
@synthesize nearField;
@synthesize termField;

@synthesize commonTerms;

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
    [tableView release];
    [searchView release];
    [nearField release];
    [termField release];
    [commonTerms release];
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
    CGPoint point = CGPointMake(1.2345, 1.2345);
    searchService = [[SearchService alloc]initWithLocation:point withDelegate:self];
    
    commonTerms = [@"Sushi,Eggs,Salmon,Egg Plants,Cheese" componentsSeparatedByString:@","];
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


//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText 
//{
    //if ([searchText length] > 1) {

    //}
//}

-(IBAction) switchSearchView:(id *) sender
{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
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
}

-(void)searchFinished:(NSMutableArray *)restaurantsArray 
{ 
    restaurantSearchResultTableViewController.restaurantsArray = [restaurantsArray retain];
    dishSearchResultTableViewController.restaurantsArray = [restaurantsArray retain];
    [tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

-(IBAction) autocomplete
{
    [searchService searchByTerm:termField.text];
}

@end
