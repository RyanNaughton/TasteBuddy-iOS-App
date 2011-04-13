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

@interface SearchViewController : UIViewController <SearchServiceDelegate, UISearchBarDelegate, UIScrollViewDelegate> {
    SearchService *searchService;
    IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
    IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
    IBOutlet UITableView *tableView;
    IBOutlet UISearchBar *searchBar;
}

@property (nonatomic, retain) SearchService *searchService;
@property (nonatomic, retain) IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

-(IBAction) switchSearchView:(id *) sender;

@end
