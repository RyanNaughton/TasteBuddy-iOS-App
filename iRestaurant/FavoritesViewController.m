//
//  FavoritesViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavoritesDishesTVC.h"
#import "FavoritesRestaurantsTVC.h"

@implementation FavoritesViewController
@synthesize restaurantsTabButton, dishesTabButton, tabView, lastSender;
@synthesize favoritesDishesTVC, favoritesRestaurantsTVC, tableView;
@synthesize ubs;

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
    [restaurantsTabButton release];
    [dishesTabButton release];
    [tabView release];
    [lastSender release];
    [favoritesDishesTVC release];
    [favoritesRestaurantsTVC release];
    [tableView release];
    [ubs release];
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
    ubs = [[UserBookmarksService alloc] initWithDelegate:self];
    UIImageView *favoritesNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"favorites-logo.png"]];
    favoritesNameImageView.frame = CGRectMake(160, -3, 150, 44);
    favoritesNameImageView.contentMode = UIViewContentModeRight;
    
    restaurantsTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [restaurantsTabButton setTitle:@"Restaurants" forState:UIControlStateNormal];
    restaurantsTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    restaurantsTabButton.frame =  CGRectMake(0, 4, 83, 35);
    [restaurantsTabButton addTarget:self action:@selector(switchFavoriteView:) forControlEvents:UIControlEventTouchUpInside];
    
    dishesTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dishesTabButton setTitle:@"Dishes" forState:UIControlStateNormal];
    dishesTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    dishesTabButton.frame =  CGRectMake(78, 4, 83, 35);
    [dishesTabButton addTarget:self action:@selector(switchFavoriteView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self switchTabs:restaurantsTabButton];
    
    lastSender = restaurantsTabButton; //Set initial value for lastSender so we knew which result view we need to be in.
    
    tabView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [tabView addSubview:favoritesNameImageView];
    [tabView addSubview:dishesTabButton];
    [tabView addSubview:restaurantsTabButton];
    self.navigationItem.titleView = tabView;
    
}

-(void) viewDidAppear:(BOOL)animated {
    if(![ubs isLoggedIn]) {
        favoritesRestaurantsTVC.restaurantsArray = [[NSArray alloc] init];
        favoritesDishesTVC.dishesArray = [[NSArray alloc] init];
        [tableView reloadData];
    }
    if(!animated) {
        favoritesDishesTVC.isLoading = YES;
        favoritesRestaurantsTVC.isLoading = YES;
        [ubs getUserBookmarks];
    }
}

-(void) switchTabs:(UIButton *) onTab 
{
    
    UIButton *offTab = (onTab == restaurantsTabButton) ? dishesTabButton : restaurantsTabButton;
    
    [offTab setBackgroundImage:[[UIImage imageNamed:@"darkgrey-tab.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [offTab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [onTab setBackgroundImage:[[UIImage imageNamed:@"grey-tab.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [onTab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [tabView bringSubviewToFront:onTab];
    
}

-(void)switchFavoriteView:(id)sender 
{
    lastSender = sender;
    if(sender == restaurantsTabButton) {
        [self switchTabs:restaurantsTabButton];
        tableView.delegate = favoritesRestaurantsTVC;
        tableView.dataSource = favoritesRestaurantsTVC;
    } else if (sender == dishesTabButton){
        [self switchTabs:dishesTabButton];
        tableView.delegate = favoritesDishesTVC;
        tableView.dataSource = favoritesDishesTVC;
    }
    [tableView reloadData];
    [tableView setContentOffset:CGPointMake(0, 0) animated:NO];
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

-(void) doneRetrievingBookmarks:(NSMutableDictionary *) bookmarks {
    favoritesRestaurantsTVC.restaurantsArray = [bookmarks objectForKey:@"restaurants"];
    favoritesDishesTVC.dishesArray = [bookmarks objectForKey:@"menu_items"];
    favoritesDishesTVC.isLoading = NO;
    favoritesRestaurantsTVC.isLoading = NO;
    [tableView reloadData];
}

@end
