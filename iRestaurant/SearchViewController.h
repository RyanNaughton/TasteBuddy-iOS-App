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

@interface SearchViewController : UIViewController <SearchServiceDelegate, UITextFieldDelegate, UIScrollViewDelegate> {
    SearchService *searchService;
    IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
    IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
    IBOutlet UITableView *tableView;
    
    IBOutlet UISegmentedControl *searchViewControl;

    UIBarButtonItem *showSearchButton;
    
    UIButton *restaurantsTabButton;
    UIButton *dishesTabButton;
}

@property (nonatomic, retain) SearchService *searchService;

@property (nonatomic, retain) IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) UIBarButtonItem *showSearchButton;

@property (nonatomic, retain) IBOutlet UISegmentedControl *searchViewControl;

@property (nonatomic, retain) UIButton *restaurantsTabButton;
@property (nonatomic, retain) UIButton *dishesTabButton;


-(IBAction) switchSearchView:(id) sender;

-(void) resultsLoading;
-(void) resultsLoaded;
@end
