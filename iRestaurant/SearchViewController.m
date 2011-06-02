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
#import "iRestaurantAppDelegate.h"
#import "RestaurantAnnotation.h"
#import "RestaurantViewController.h"
#import "FindAutocompleteTableViewController.h"
#import "SearchSortAndFilterViewController.h"
#import "SortAndFilterPreferences.h"


@implementation SearchViewController

@synthesize searchService;
@synthesize restaurantSearchResultTableViewController, dishSearchResultTableViewController;
@synthesize showSearchButton;
@synthesize tableView;

@synthesize restaurantsTabButton, dishesTabButton, mapButton, filterButton;

@synthesize searchModalViewController;

@synthesize fakeTermField, searchIcon;

@synthesize lastSender;
@synthesize tabView;

@synthesize needsToPerformDefaultSearch;

@synthesize mapView;

@synthesize sortAndFilterPreferences;


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
    [sortAndFilterPreferences release];
    [searchService release];
    [restaurantSearchResultTableViewController release];
    [dishSearchResultTableViewController release];
    //[tableView release];
    [showSearchButton release];
    [searchViewControl release];
    [searchModalViewController release];
    [fakeTermField release];
    [mapButton release];
    [filterButton release];
    [lastSender release];
    [dishesTabButton release];
    [restaurantsTabButton release];
    [tabView release];
    [mapView release];
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
    
    tableView.backgroundColor = [UIColor clearColor];
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pepperbg_final.png"]];
//    tableView.backgroundView = imageView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fireSearch) name:@"fireSearch" object:nil];
    
    fakeTermField.frame = CGRectMake(7, 7, 254, 31);

    //needsToPerformDefaultSearch = YES;
    UIImage *greyButtonImage = [[UIImage imageNamed:@"grey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    [mapButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
    [filterButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
    
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tasteBuddyLogo.png"]];
    appNameImageView.frame = CGRectMake(160, -3, 150, 44);
    appNameImageView.contentMode = UIViewContentModeRight;
    
    dishesTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dishesTabButton setTitle:@"Dishes" forState:UIControlStateNormal];
    dishesTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    dishesTabButton.frame = CGRectMake(0, 4, 83, 35); 
    [dishesTabButton addTarget:self action:@selector(switchSearchView:) forControlEvents:UIControlEventTouchUpInside];
    
    restaurantsTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [restaurantsTabButton setTitle:@"Restaurants" forState:UIControlStateNormal];
    restaurantsTabButton.titleLabel.font = [UIFont systemFontOfSize:13];
    restaurantsTabButton.frame = CGRectMake(78, 4, 83, 35);
    [restaurantsTabButton addTarget:self action:@selector(switchSearchView:) forControlEvents:UIControlEventTouchUpInside];

    [self switchTabs:dishesTabButton];

    lastSender = dishesTabButton; //Set initial value for lastSender so we knew which result view we need to be in.

    tabView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [tabView addSubview:appNameImageView];
    [tabView addSubview:dishesTabButton];
    [tabView addSubview:restaurantsTabButton];
    self.navigationItem.titleView = tabView;
    
    // Do any additional setup after loading the view from its nib.    
    CGPoint point = CGPointMake(1.2345, 1.2345);
    searchService = [[SearchService alloc]initWithLocation:point withDelegate:self];

    [self switchSearchView:dishesTabButton]; //Show no results initially.
    
}

-(void) viewDidAppear:(BOOL)animated {
    if(needsToPerformDefaultSearch) {
        needsToPerformDefaultSearch = NO;
        [self resultsLoading];
        [searchService searchByTerm:@""];
    }
    [self.tableView reloadData];
}

-(void)fireSearch {
    needsToPerformDefaultSearch = NO;
    [self resultsLoading];
    [searchService searchByTerm:@""];
    [self.tableView reloadData];
}

-(void) switchTabs:(UIButton *) onTab 
{
    
    UIButton *offTab;
    [UIView beginAnimations:nil context:nil];
    if (onTab == restaurantsTabButton) {
        offTab = dishesTabButton;
        fakeTermField.frame = CGRectMake(7, 7, 207, 31);
        filterButton.alpha = 1.0;
        mapButton.alpha = 1.0;
    } else {
        offTab = restaurantsTabButton;
        fakeTermField.frame = CGRectMake(7, 7, 306, 31);
        filterButton.alpha = 0.0;
        mapButton.alpha = 0.0;
    }
    [UIView setAnimationDuration:0.2];
    [UIView commitAnimations];
    mapView.hidden = YES;
    [offTab setBackgroundImage:[[UIImage imageNamed:@"darkgrey-tab.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [offTab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [onTab setBackgroundImage:[[UIImage imageNamed:@"grey-tab.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [onTab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [tabView bringSubviewToFront:onTab];
    
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
    
    NSLog(@"switch hit");
    
    if (lastSender == restaurantsTabButton) {
        searchModalViewController.findAutocompleteTableViewController.currentSearchTabTitle = [@"Restaurants" retain];
    } else {
        searchModalViewController.findAutocompleteTableViewController.currentSearchTabTitle = [@"Dishes" retain];
    }
    [searchModalViewController.findAutocompleteTableViewController refereshTable];
    
    if(sender == restaurantsTabButton) {
        [self switchTabs:restaurantsTabButton];
        tableView.delegate = restaurantSearchResultTableViewController;
        tableView.dataSource = restaurantSearchResultTableViewController;
        [tableView reloadData];
        tableView.hidden = false;
        mapView.hidden = true;
        fakeTermField.placeholder = @"      Restaurants";
        [mapButton setTitle:@"Map" forState:UIControlStateNormal];
    } else if (sender == dishesTabButton){
        [self switchTabs:dishesTabButton];
        tableView.delegate = dishSearchResultTableViewController;
        tableView.dataSource = dishSearchResultTableViewController;
        [tableView reloadData];
        tableView.hidden = false;
        mapView.hidden = true;
        fakeTermField.placeholder = @"      Dishes";
    } else if (sender == mapButton && [mapButton.titleLabel.text isEqualToString:@"Map"]) {
        tableView.hidden = true;
        mapView.hidden = false;
        [mapButton setTitle:@"List" forState:UIControlStateNormal];
    } else if (sender == mapButton && [mapButton.titleLabel.text isEqualToString:@"List"]) {
        [mapButton setTitle:@"Map" forState:UIControlStateNormal];
        [self switchSearchView:restaurantsTabButton];
    }

    [tableView setContentOffset:CGPointMake(0, 0) animated:NO];

    //Need to scroll to top here
}

-(void)updateSearchTermField {
    if (![fakeTermField.text isEqualToString:@""]) {
        searchIcon.alpha = 0.0;
    } else {
        searchIcon.alpha = 0.35;
    }
}

-(void)searchFinished:(NSMutableArray *)restaurantsArray 
{ 
    restaurantSearchResultTableViewController.restaurantsArray = [restaurantsArray retain];
    restaurantSearchResultTableViewController.filteredArray = [restaurantsArray retain];
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
    [self setUpAnnotations];
}

-(IBAction) filterPressed {
//    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    SearchSortAndFilterViewController *ssafvc = [[SearchSortAndFilterViewController alloc] initWithNibName:@"SearchSortAndFilterViewController" bundle:nil andSearchViewController:self];
    [self presentModalViewController:ssafvc animated:YES];
    [ssafvc release];
//    UIActionSheet *filterActionSheet = [[UIActionSheet alloc] initWithTitle:@"Sort" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Distance", @"Rating", @"Average Dish Price", nil];
//    [filterActionSheet showFromTabBar:appDelegate.tabBarController.tabBar];
//    [filterActionSheet release];
}

-(void) sortAndFilterRestaurantResults {
    if (sortAndFilterPreferences.sortIndex > -1) {
        NSSortDescriptor *sortDescriptor;
        if(sortAndFilterPreferences.sortIndex == 0) {
            sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"distance"
                                                          ascending:YES] autorelease];        
            
        } else if(sortAndFilterPreferences.sortIndex == 1) {
            sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"rating.sortValue"
                                                          ascending:NO] autorelease];  
            
        } else if(sortAndFilterPreferences.sortIndex == 2) {
            sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"average_meal_price"
                                                          ascending:YES] autorelease];
        }
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray = [restaurantSearchResultTableViewController.restaurantsArray sortedArrayUsingDescriptors:sortDescriptors];
        restaurantSearchResultTableViewController.restaurantsArray = [NSMutableArray arrayWithArray: sortedArray];
    } 
    
     if (sortAndFilterPreferences.distanceIndex > -1 || sortAndFilterPreferences.priceIndex > -1) {
         restaurantSearchResultTableViewController.filteredArray = [[NSMutableArray alloc] init];
     } else {
         restaurantSearchResultTableViewController.filteredArray = [restaurantSearchResultTableViewController.restaurantsArray retain];
     }
    
    if(sortAndFilterPreferences.distanceIndex > -1) {
        float distance = 0.0;
        if(sortAndFilterPreferences.distanceIndex == 0) {
            distance = 0.5;
        } else if (sortAndFilterPreferences.distanceIndex == 1){
            distance = 1.0;
        } else if (sortAndFilterPreferences.distanceIndex == 2){
            distance = 5.0;
        } else if (sortAndFilterPreferences.distanceIndex == 3){
            distance = 10.0;
        }
        for(Restaurant *r in restaurantSearchResultTableViewController.restaurantsArray) {
            if([r.distance floatValue] <= distance) [restaurantSearchResultTableViewController.filteredArray addObject:r];
        }
    }
    
    if(sortAndFilterPreferences.priceIndex > -1) {
        float priceFrom = 0.0;
        float priceTo = 0.0;
        
        if(sortAndFilterPreferences.priceIndex == 0) {
            priceTo = 10.0;
        } else if(sortAndFilterPreferences.priceIndex == 1) {
            priceFrom = 10.0;
            priceTo = 20.0;
        } else if(sortAndFilterPreferences.priceIndex == 2) {
            priceFrom = 20.0;
            priceTo = 40.0;
        } else if(sortAndFilterPreferences.priceIndex == 3) {
            priceFrom = 40.0;
            priceTo = 100000.0;
        }
        
        NSMutableArray *arrayToFilter;
        if(sortAndFilterPreferences.distanceIndex > -1) {
            arrayToFilter = restaurantSearchResultTableViewController.filteredArray;
        } else {
            arrayToFilter = restaurantSearchResultTableViewController.restaurantsArray;
        }
        NSMutableArray *newFilteredArray = [[NSMutableArray alloc] init];
        for(Restaurant *r in arrayToFilter) {
            if(r.average_meal_price >= priceFrom && r.average_meal_price <= priceTo) [newFilteredArray addObject:r];
        }
        restaurantSearchResultTableViewController.filteredArray = newFilteredArray;
        
    }
    
    
    if (sortAndFilterPreferences.distanceIndex > -1 || sortAndFilterPreferences.sortIndex > -1 || sortAndFilterPreferences.priceIndex > -1) {
        [tableView reloadData];
    }
    
    
}
-(IBAction) presentSearchModal {
    
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate updateLocation];
    
    [fakeTermField resignFirstResponder];
    //searchModalViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[self presentModalViewController:searchModalViewController animated:YES];
    
    searchModalViewController.view.frame = CGRectMake(0, -20, 320, 366);
    searchModalViewController.view.alpha = 0.0;
    
    [self.view addSubview:searchModalViewController.view];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.333];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    searchModalViewController.view.alpha = 1.0;
    searchModalViewController.view.frame = CGRectMake(0, 0, 320, 366);
    [UIView setAnimationDidStopSelector:@selector(makeWhatFirstResponder)];
    [UIView commitAnimations];
}

-(void) makeWhatFirstResponder {
    if (lastSender == restaurantsTabButton) {
        searchModalViewController.findAutocompleteTableViewController.currentSearchTabTitle = [@"Restaurants" retain];
    } else {
        searchModalViewController.findAutocompleteTableViewController.currentSearchTabTitle = [@"Dishes" retain];
    }
    [searchModalViewController.termField becomeFirstResponder];
}

-(void) setUpAnnotations {
    int annotations = 0;
    double maxLng   = 0;
    double maxLat   = 0;
    double minLng   = 0;
    double minLat   = 0;
    
    [mapView removeAnnotations:mapView.annotations];
    for (Restaurant *restaurant in restaurantSearchResultTableViewController.restaurantsArray) {
        if(restaurant.location.longitude != 0 && restaurant.location.latitude != 0) {
            RestaurantAnnotation *annotation = [[RestaurantAnnotation alloc] initWithRestaurant:restaurant];
            [mapView addAnnotation:annotation];
            [annotation release];
            
            if (annotations == 0) {
                maxLat = restaurant.location.latitude;
                minLat = restaurant.location.latitude;
                maxLng = restaurant.location.longitude;
                minLng = restaurant.location.longitude;
            } else {
                if(minLat > restaurant.location.latitude) minLat = restaurant.location.latitude;
                if(maxLat < restaurant.location.latitude) maxLat = restaurant.location.latitude;
                if(minLng > restaurant.location.longitude) minLng = restaurant.location.longitude;
                if(maxLng < restaurant.location.longitude) maxLng = restaurant.location.longitude;

            }
            
            annotations++;
        }
    }   
    
    CLLocation *locSouthWest = [[CLLocation alloc] initWithLatitude:minLat longitude:minLng];
    CLLocation *locNorthEast = [[CLLocation alloc] initWithLatitude:maxLat longitude:maxLng];
    
    CLLocationDistance meters = [locSouthWest distanceFromLocation:locNorthEast];
    
    if (annotations == 0) {
        meters = 10000;
        iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
        maxLat = appDelegate.currentLocation.coordinate.latitude;
        minLat = appDelegate.currentLocation.coordinate.latitude;
        minLng = appDelegate.currentLocation.coordinate.longitude;
        maxLng = appDelegate.currentLocation.coordinate.longitude;
    } 
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
	region.center.latitude = (maxLat + minLat)/2;
	region.center.longitude = (maxLng + minLng)/2;
    region.span.latitudeDelta = meters / 111319.5;
    region.span.longitudeDelta = 0.0;

	[mapView setRegion:region animated:NO]; 
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation: (id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		static NSString *defaultPinID = @"restaurantPin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		pinView.canShowCallout = YES;
		pinView.animatesDrop = NO;
        
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = infoButton;
	} 
	else {
		[mapView.userLocation setTitle:@"You are here"];
	}
	return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control { 
	if([view.annotation isKindOfClass:[RestaurantAnnotation class]]){
        RestaurantAnnotation *ra = (RestaurantAnnotation *)view.annotation;
        RestaurantViewController *restaurantViewController = [[RestaurantViewController alloc] initWithRestaurant:ra.restaurant];
        [self.navigationController pushViewController:restaurantViewController animated:YES];
        [restaurantViewController release];

	}
	
}




@end
