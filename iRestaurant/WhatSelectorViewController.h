//
//  WhatSelectorViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 6/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WhatSelectorTableViewController;
@class MenuItem;
@class Restaurant;

@protocol WhatSelectorDelegate <NSObject>
-(void) whatSelected:(MenuItem *)menu_item_passed;
@end


@interface WhatSelectorViewController : UIViewController {
    id <WhatSelectorDelegate> delegate;
    IBOutlet WhatSelectorTableViewController *whatSelectorTableViewController;
    NSString *restaurant_id;
}

@property (nonatomic, retain) id <WhatSelectorDelegate> delegate;
@property (nonatomic, retain) IBOutlet WhatSelectorTableViewController *whatSelectorTableViewController;
@property (nonatomic, retain) NSString *restaurant_id;

- (id)initWithRestaurantID:(NSString *)restaurant_id_passed;
-(IBAction)cancelButtonPressed;

@end
