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
#import "iRestaurantAppDelegate.h"

@implementation FavoritesViewController
@synthesize restaurantsTabButton, dishesTabButton, tabView, lastSender;
@synthesize favoritesDishesTVC, favoritesRestaurantsTVC, tableView;
@synthesize ubs, initialSetup;

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

-(void) checkLogin {
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate loggedIn]) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        self.navigationItem.titleView = tabView;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        
    } else {
                
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIImageView *favoritesNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"favoritesLogo.png"]];
        favoritesNameImageView.frame = CGRectMake(160, -3, 320, 44);
        favoritesNameImageView.contentMode = UIViewContentModeRight;
        self.navigationItem.titleView = favoritesNameImageView;
        
        UIBarButtonItem *loginBtn = [[UIBarButtonItem alloc] initWithTitle:@"Login"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(loginPressed:)]; 
        self.navigationItem.leftBarButtonItem = loginBtn;
        self.navigationItem.rightBarButtonItem = nil;
        [loginBtn release]; 
    }
    
}

-(void)setupNavBarContent {
    UIImageView *favoritesNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"favoritesLogo.png"]];
    favoritesNameImageView.frame = CGRectMake(160, -3, 150, 44);
    favoritesNameImageView.contentMode = UIViewContentModeRight;
    
    dishesTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dishesTabButton setTitle:@"Dishes" forState:UIControlStateNormal];
    dishesTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    dishesTabButton.frame = CGRectMake(0, 4, 83, 35); 
    [dishesTabButton addTarget:self action:@selector(switchFavoriteView:) forControlEvents:UIControlEventTouchUpInside];

    
    restaurantsTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [restaurantsTabButton setTitle:@"Restaurants" forState:UIControlStateNormal];
    restaurantsTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    restaurantsTabButton.frame = CGRectMake(78, 4, 83, 35);
    [restaurantsTabButton addTarget:self action:@selector(switchFavoriteView:) forControlEvents:UIControlEventTouchUpInside];
    
        
    tabView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [tabView addSubview:favoritesNameImageView];
    [tabView addSubview:restaurantsTabButton];
    [tabView addSubview:dishesTabButton];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.titleView = tabView;
    
    //lastSender = restaurantsTabButton;
    //[self switchFavoriteView:dishesTabButton];
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
    [self setTitle:@"Favorites"];
    initialSetup = TRUE;
    ubs = [[UserBookmarksService alloc] initWithDelegate:self];
    
    [self setupNavBarContent];
    
    lastSender = dishesTabButton;
    [self switchFavoriteView:dishesTabButton];
}

-(void) viewDidAppear:(BOOL)animated {
    
    NSLog(@"favorites view did appear");
    [self.tableView reloadData];

    if(![ubs isLoggedIn]) {
        [self checkLogin];
        [self setActiveTab:lastSender];
        favoritesRestaurantsTVC.restaurantsArray = [[NSMutableArray alloc] init];
        favoritesDishesTVC.dishesArray = [[NSMutableArray alloc] init];
    } else {
        [self setActiveTab:lastSender];
    }
    if(!animated) {
        favoritesDishesTVC.isLoading = YES;
        favoritesRestaurantsTVC.isLoading = YES;
        [ubs getUserBookmarks];
    }
}

-(void) setActiveTab:(UIButton *) activeTab 
{
    NSLog(@"setActiveTab %@", activeTab.titleLabel.text);
    UIButton *inactiveTab;
    if (activeTab == dishesTabButton) {
        activeTab = dishesTabButton;
        inactiveTab = restaurantsTabButton;
    } else {
        activeTab = restaurantsTabButton;
        inactiveTab = dishesTabButton;
    }
        [inactiveTab setBackgroundImage:[[UIImage imageNamed:@"darkgrey-tab.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [inactiveTab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [activeTab setBackgroundImage:[[UIImage imageNamed:@"grey-tab.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [activeTab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];   
        [tabView bringSubviewToFront:activeTab];
}

-(void)switchFavoriteView:(id)sender 
{
    lastSender = sender;
    if(sender == restaurantsTabButton) {
        NSLog(@"restaurant tab");
        [self setActiveTab:restaurantsTabButton];
        tableView.delegate = favoritesRestaurantsTVC;
        tableView.dataSource = favoritesRestaurantsTVC;
    } else if (sender == dishesTabButton){
        NSLog(@"dishes tab");
        [self setActiveTab:dishesTabButton];
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
      
    NSLog(@"we have bookmarks: %@", bookmarks);
    
    favoritesRestaurantsTVC.restaurantsArray = [bookmarks objectForKey:@"restaurants"];
    
    NSLog(@"restaurants array: %@", [bookmarks objectForKey:@"restaurants"]);
    
    favoritesDishesTVC.dishesArray = [bookmarks objectForKey:@"menu_items_by_restaurant"];
    favoritesDishesTVC.isLoading = NO;
    favoritesRestaurantsTVC.isLoading = NO;
    
    [self checkLogin];
    //[self switchTabs:lastSender];
    
    [tableView reloadData];
}

-(void)loginPressed:(id)sender 
{
    NSLog(@"login pressed");
    [self viewDidAppear:NO];
}

@end
