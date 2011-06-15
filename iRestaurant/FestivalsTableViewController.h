//
//  FestivalsTableViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FestivalsViewController;

@interface FestivalsTableViewController : UITableViewController {
    NSMutableArray *festivals;
    FestivalsViewController *festivalsViewController;

}

@property (nonatomic, retain) NSMutableArray *festivals;
@property (nonatomic, retain) FestivalsViewController *festivalsViewController;
@end
