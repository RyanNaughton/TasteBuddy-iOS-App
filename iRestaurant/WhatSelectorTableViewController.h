//
//  WhatSelectorTableViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 6/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuService.h"

@class Restaurant;

@interface WhatSelectorTableViewController : UITableViewController <UISearchBarDelegate, MenuServiceDelegate> {
    IBOutlet UISearchBar *searchBar;
    NSMutableArray *unfilteredList;
    NSMutableArray *filteredList;
    id delegate;
    MenuService *ms;
    Restaurant *restaurant;
}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSMutableArray *unfilteredList;
@property (nonatomic, retain) NSMutableArray *filteredList;
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) MenuService *ms;
@property (nonatomic, retain) Restaurant *restaurant;

-(void)menuReturned:(Menu *)menu;

@end
