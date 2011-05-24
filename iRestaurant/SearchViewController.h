//
//  SearchViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SearchService.h"
#import <MapKit/MapKit.h>
@class RestaurantSearchResultTableViewController;
@class DishSearchResultTableViewController;
@class AutocompleteModalViewController;

@interface SearchViewController : UIViewController <SearchServiceDelegate, UITextFieldDelegate, UIScrollViewDelegate, UIActionSheetDelegate, MKMapViewDelegate> {
    SearchService *searchService;
    IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
    IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
    IBOutlet UITableView *tableView;
    
    IBOutlet UISegmentedControl *searchViewControl;

    UIBarButtonItem *showSearchButton;
    
    UIButton *restaurantsTabButton;
    UIButton *dishesTabButton;
    
    IBOutlet UIButton *filterButton;
    IBOutlet UIButton *mapButton;
    
    IBOutlet AutocompleteModalViewController *searchModalViewController;
    
    IBOutlet UITextField *fakeTermField;
    IBOutlet UIImageView *searchIcon;
    
    IBOutlet MKMapView *mapView;
    
    UIView *tabView;
    
    id lastSender;
    
    bool needsToPerformDefaultSearch;
    
}

@property (nonatomic, retain) SearchService *searchService;

@property (nonatomic, retain) IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) UIBarButtonItem *showSearchButton;

@property (nonatomic, retain) UIButton *restaurantsTabButton;
@property (nonatomic, retain) UIButton *dishesTabButton;

@property (nonatomic, retain) IBOutlet UIButton *mapButton;
@property (nonatomic, retain) IBOutlet UIButton *filterButton;

@property (nonatomic, retain) IBOutlet AutocompleteModalViewController *searchModalViewController;

@property (nonatomic, retain) IBOutlet UITextField *fakeTermField;
@property (nonatomic, retain) IBOutlet UIImageView *searchIcon;
@property (nonatomic, retain) id lastSender;
@property (nonatomic, retain) UIView *tabView;
@property (nonatomic, assign) bool needsToPerformDefaultSearch;

@property (nonatomic, assign) IBOutlet MKMapView *mapView;


-(IBAction) switchSearchView:(id) sender;
-(IBAction) mapButtonPressed:(id) sender;

-(void) resultsLoading;
-(void) resultsLoaded;

-(IBAction) presentSearchModal;
-(void) switchTabs:(UIButton *) onTab;
-(void) makeWhatFirstResponder;
-(void) fireSearch;

-(void) setUpAnnotations;

@end
