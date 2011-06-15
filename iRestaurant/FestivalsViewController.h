//
//  FestivalsViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FestivalsService.h"
#import "FestivalsTableViewController.h"

@interface FestivalsViewController : UIViewController<FestivalsServiceDelegate> {
    IBOutlet FestivalsTableViewController *festivalsTableViewController;
    FestivalsService *service;
}

@property (nonatomic, retain) IBOutlet FestivalsTableViewController *festivalsTableViewController;
@property (nonatomic, retain) FestivalsService *service;
@end
