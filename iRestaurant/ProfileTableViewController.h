//
//  ProfileTableViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfileService.h"

@interface ProfileTableViewController : UITableViewController <UserProfileServiceDelegate> {
    UserProfileService *ups;
}

@property (nonatomic, retain) UserProfileService *ups;

-(IBAction) logoutPressed:(id)sender;
-(void) doneRetrievingProfile:(NSMutableDictionary *) profile;

@end
