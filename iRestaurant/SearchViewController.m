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
#import "AutocompleteModalViewController.h"

@implementation SearchViewController

@synthesize searchService;
@synthesize restaurantSearchResultTableViewController, dishSearchResultTableViewController;
@synthesize showSearchButton;
@synthesize tableView;

@synthesize restaurantsTabButton, dishesTabButton, mapButton;

@synthesize searchModalViewController;

@synthesize fakeTermField;

@synthesize lastSender;

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
    [showSearchButton release];
    [searchViewControl release];
    [searchModalViewController release];
    [fakeTermField release];
    [mapButton release];
    [lastSender release];
    [dishesTabButton release];
    [restaurantsTabButton release];
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
    
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iRestaurant-logo"]];
    appNameImageView.frame = CGRectMake(0, 0, 305, 35);
    appNameImageView.contentMode = UIViewContentModeRight;
    
    restaurantsTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [restaurantsTabButton setTitle:@"Restaurants" forState:UIControlStateNormal];
    restaurantsTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    restaurantsTabButton.frame =  CGRectMake(0, 4, 80, 35);
    [restaurantsTabButton addTarget:self action:@selector(switchSearchView:) forControlEvents:UIControlEventTouchUpInside];
    
    dishesTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dishesTabButton setTitle:@"Dishes" forState:UIControlStateNormal];
    dishesTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    dishesTabButton.frame =  CGRectMake(80, 4, 80, 35);
    [dishesTabButton addTarget:self action:@selector(switchSearchView:) forControlEvents:UIControlEventTouchUpInside];

    [self switchTabs:restaurantsTabButton];

    lastSender = restaurantsTabButton; //Set initial value for lastSender so we knew which result view we need to be in.

    UIView *tabView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [tabView addSubview:appNameImageView];
    [tabView addSubview:restaurantsTabButton];
    [tabView addSubview:dishesTabButton];
    self.navigationItem.titleView = tabView;
    [tabView release];
    
    // Do any additional setup after loading the view from its nib.    
    CGPoint point = CGPointMake(1.2345, 1.2345);
    searchService = [[SearchService alloc]initWithLocation:point withDelegate:self];

    [self presentSearchModal];
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
    lastSender = sender;
    if(sender == restaurantsTabButton) {
        [self switchTabs:restaurantsTabButton];
        tableView.delegate = restaurantSearchResultTableViewController;
        tableView.dataSource = restaurantSearchResultTableViewController;
        [tableView reloadData];
        tableView.hidden = false;
    } else if (sender == dishesTabButton){
        [self switchTabs:dishesTabButton];
        tableView.delegate = dishSearchResultTableViewController;
        tableView.dataSource = dishSearchResultTableViewController;
        [tableView reloadData];
        tableView.hidden = false;
    } else if (sender == mapButton) {
        tableView.hidden = true;
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

-(IBAction) presentSearchModal {
    [fakeTermField resignFirstResponder];
    [self presentModalViewController:searchModalViewController animated:YES];
}

-(void) switchTabs:(UIButton *) onTab 
{

    UIButton *offTab = (onTab == restaurantsTabButton) ? dishesTabButton : restaurantsTabButton;
        
    [offTab setBackgroundImage:nil forState:UIControlStateNormal];
    [offTab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [onTab setBackgroundImage:[[UIImage imageNamed:@"grey-tab.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [onTab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}
@end
