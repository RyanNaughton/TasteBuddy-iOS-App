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
    IBOutlet UISearchBar *searchBar;
    IBOutlet UIView *searchView;
    IBOutlet UITextField *termField;
    IBOutlet UITextField *nearField;

    NSArray *commonTerms;

}

@property (nonatomic, retain) SearchService *searchService;
@property (nonatomic, retain) IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet DishSearchResultTableViewController *dishSearchResultTableViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) IBOutlet UIView *searchView;
@property (nonatomic, retain) IBOutlet UITextField *termField;
@property (nonatomic, retain) IBOutlet UITextField *nearField;

@property (nonatomic, retain) NSArray *commonTerms;

-(IBAction) switchSearchView:(id *) sender;
-(IBAction) autocomplete;

@end
