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

@interface SearchViewController : UIViewController <SearchServiceDelegate> {
    SearchService *searchService;
    IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;
}

@property (nonatomic, retain) SearchService *searchService;
@property (nonatomic, retain) IBOutlet RestaurantSearchResultTableViewController *restaurantSearchResultTableViewController;

-(IBAction) switchSearchView:(id *) sender;

@end
