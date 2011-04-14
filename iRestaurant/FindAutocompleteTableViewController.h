//
//  FindAutocompleteTableViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 14/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutocompleteService.h"

@interface FindAutocompleteTableViewController : UITableViewController <AutocompleteServiceDelegate> {
    NSArray *values;
    IBOutlet UITextField *findField;
    IBOutlet UITextField *nearField;
}

@property (nonatomic, retain) NSArray *values;
@property (nonatomic, retain) IBOutlet UITextField *findField;
@property (nonatomic, retain) IBOutlet UITextField *nearField;

@end