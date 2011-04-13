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

@implementation SearchViewController

@synthesize searchService;
@synthesize restaurantSearchResultTableViewController, dishSearchResultTableViewController;
@synthesize tableView;

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
    [searchService searchByTerm:@"bla"];
    
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

-(IBAction) switchSearchView:(id *) sender
{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            NSLog(@"Restaurant.");
            tableView.delegate = restaurantSearchResultTableViewController;
            tableView.dataSource = restaurantSearchResultTableViewController;
            [tableView reloadData];
            tableView.hidden = false;
            break;
        case 1:
            NSLog(@"Dishes");
            tableView.delegate = dishSearchResultTableViewController;
            tableView.dataSource = dishSearchResultTableViewController;
            [tableView reloadData];
            tableView.hidden = false;
            break;
        case 2:
            NSLog(@"Map");
            tableView.hidden = true;
            break;
        default:
            break;
    }   
}

-(void)searchFinished:(NSMutableArray *)restaurantsArray 
{
    restaurantSearchResultTableViewController.restaurantsArray = restaurantsArray;
    dishSearchResultTableViewController.restaurantsArray = restaurantsArray;
    [tableView reloadData];
}


@end
