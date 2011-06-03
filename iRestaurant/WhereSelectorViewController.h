//
//  WhereSelectorViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 6/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WhereSelectorTableViewController;
@class Restaurant;

@protocol WhereSelectorDelegate <NSObject>
-(void) whereSelected:(Restaurant *)restaurant_passed;
@end

@interface WhereSelectorViewController : UIViewController {
    id <WhereSelectorDelegate> delegate;
    IBOutlet WhereSelectorTableViewController *whereSelectorTableViewController;
}

@property (nonatomic, retain) id <WhereSelectorDelegate> delegate;
@property (nonatomic, retain) IBOutlet WhereSelectorTableViewController *whereSelectorTableViewController;

-(IBAction)cancelButtonPressed;

@end
