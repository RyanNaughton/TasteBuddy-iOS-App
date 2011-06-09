//
//  WhereSelectorTableViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 6/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchService.h"

@interface WhereSelectorTableViewController : UITableViewController <UISearchBarDelegate, SearchServiceDelegate> {
    IBOutlet UISearchBar *searchBar;
    NSMutableArray *unfilteredList;
    NSMutableArray *filteredList;
    SearchService *ss;
    id delegate;
    BOOL loading;
}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSMutableArray *unfilteredList;
@property (nonatomic, retain) NSMutableArray *filteredList;
@property (nonatomic, retain) SearchService *ss;
@property (nonatomic, retain) id delegate;
@property (nonatomic, assign) BOOL loading;

-(void)searchFinished:(NSMutableArray *)restaurantsArray;

@end
