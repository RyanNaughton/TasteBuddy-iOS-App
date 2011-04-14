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
    IBOutlet UISearchBar *searchBar;
    IBOutlet UIView *searchView;
    IBOutlet UITextField *termField;
    IBOutlet UITextField *nearField;
    
    IBOutlet FindAutocompleteTableViewController *findAutocompleteTableViewController;
    IBOutlet NearAutocompleteTableViewController *nearAutocompleteTableViewController;

}

@property (nonatomic, retain) SearchService *searchService;
@property (nonatomic, retain) AutocompleteService *autocompleteService;


@property (nonatomic, retain) IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) IBOutlet UIView *searchView;
@property (nonatomic, retain) IBOutlet UITextField *termField;
@property (nonatomic, retain) IBOutlet UITextField *nearField;

@property (nonatomic, retain) IBOutlet FindAutocompleteTableViewController *findAutocompleteTableViewController;
@property (nonatomic, retain) IBOutlet NearAutocompleteTableViewController *nearAutocompleteTableViewController;


-(IBAction) switchSearchView:(id *) sender;
-(IBAction) autocomplete:(id *) sender;

-(void) searchViewAnimateIn;
-(void) searchViewAnimateOut;

@end
