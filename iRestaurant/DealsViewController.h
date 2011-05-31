//
//  DealsViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/31/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealsService.h"

@interface DealsViewController : UITableViewController <DealsServiceDelegate> {
    DealsService *ds;
    NSArray *dealsArray;
    UIImage *noImage;
}

@property (nonatomic, retain) DealsService *ds;
@property (nonatomic, retain) NSArray *dealsArray;
@property (nonatomic, retain) UIImage *noImage;

-(void) dealDataReturned:(NSDictionary *)dict;

@end
