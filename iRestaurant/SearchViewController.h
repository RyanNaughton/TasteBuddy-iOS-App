//
//  SearchViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchService.h"
#import "AutocompleteService.h"

@class RestaurantSearchResultTableViewController;
@class DishSearchResultTableViewController;
@class FindAutocompleteTableViewController;
@class NearAutocompleteTableViewController;

@interface SearchViewController : UIViewController <SearchServiceDelegate, UITextFieldDelegate, UIScrollViewDelegate> {
    SearchService *searchService;
    AutocompleteService *autocompleteService;
    IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
    IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
    IBOutlet UITableView *tableView;
    IBOutlet UIView *searchView;
    IBOutlet UITextField *termField;
    IBOutlet UITextField *nearField;
    
    IBOutlet FindAutocompleteTableViewController *findAutocompleteTableViewController;
    IBOutlet NearAutocompleteTableViewController *nearAutocompleteTableViewController;
    
    IBOutlet UISegmentedControl *searchViewControl;

    UIBarButtonItem *showSearchButton;
}

@property (nonatomic, retain) SearchService *searchService;
@property (nonatomic, retain) AutocompleteService *autocompleteService;


@property (nonatomic, retain) IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) IBOutlet UIView *searchView;
@property (nonatomic, retain) IBOutlet UITextField *termField;
@property (nonatomic, retain) IBOutlet UITextField *nearField;

@property (nonatomic, retain) IBOutlet FindAutocompleteTableViewController *findAutocompleteTableViewController;
@property (nonatomic, retain) IBOutlet NearAutocompleteTableViewController *nearAutocompleteTableViewController;

@property (nonatomic, retain) UIBarButtonItem *showSearchButton;

@property (nonatomic, retain) IBOutlet UISegmentedControl *searchViewControl;


-(IBAction) switchSearchView:(id) sender;
-(IBAction) autocomplete:(id) sender;

-(void) searchViewAnimateIn;
-(void) searchViewAnimateOut;

-(void) resultsLoading;
-(void) resultsLoaded;
@end
