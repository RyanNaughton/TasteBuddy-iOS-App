//
//  SearchSortAndFilterViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 31/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchViewController;

@interface SearchSortAndFilterViewController : UIViewController {
    IBOutlet UISegmentedControl *sortControl;
    IBOutlet UISegmentedControl *distanceControl;
    IBOutlet UISegmentedControl *priceControl;
    SearchViewController *svc;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *sortControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *distanceControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *priceControl;
@property (nonatomic, retain) SearchViewController *svc;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andSearchViewController:(SearchViewController *) searchViewController;
-(IBAction) donePressed;
-(IBAction) cancelPressed;
@end
