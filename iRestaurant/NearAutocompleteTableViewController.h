//
//  NearAutocompleteTableViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 14/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutocompleteService.h"


@interface NearAutocompleteTableViewController : UITableViewController  <AutocompleteServiceDelegate> {
    NSArray *values;
    IBOutlet UITextField *nearField;
}

@property (nonatomic, retain) NSArray *values;
@property (nonatomic, retain) IBOutlet UITextField *nearField;

@end
