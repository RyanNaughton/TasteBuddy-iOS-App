//
//  WhereSelectorViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 6/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WhereSelectorTableViewController;

@interface WhereSelectorViewController : UIViewController {
    IBOutlet WhereSelectorTableViewController *whereSelectorTableViewController;
}

@property (nonatomic, retain) IBOutlet WhereSelectorTableViewController *whereSelectorTableViewController;

-(IBAction)cancelButtonPressed;

@end
