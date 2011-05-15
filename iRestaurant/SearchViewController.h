//
//  SearchViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchService.h"

@class RestaurantSearchResultTableViewController;
@class DishSearchResultTableViewController;
@class AutocompleteModalViewController;

@interface SearchViewController : UIViewController <SearchServiceDelegate, UITextFieldDelegate, UIScrollViewDelegate> {
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
@property (nonatomic, retain) id lastSender;
@property (nonatomic, retain) UIView *tabView;
@property (nonatomic, assign) bool needsToPerformDefaultSearch;

-(IBAction) switchSearchView:(id) sender;

-(void) resultsLoading;
-(void) resultsLoaded;

-(IBAction) presentSearchModal;
-(void) switchTabs:(UIButton *) onTab;
@end
