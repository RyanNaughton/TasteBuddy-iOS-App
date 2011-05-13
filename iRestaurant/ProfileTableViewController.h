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
    BOOL dataReceived;
    BOOL loading;
    int reviewsCount;
    int picturesCount;
    NSDictionary *picturesDictionary;
    NSMutableArray *picturesArray;
    NSString *username;
}

@property (nonatomic, retain) UserProfileService *ups;
@property (nonatomic, assign) BOOL dataReceived;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) int reviewsCount;
@property (nonatomic, assign) int picturesCount;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSDictionary *picturesDictionary;
@property (nonatomic, retain) NSMutableArray *picturesArray;


-(IBAction) logoutPressed:(id)sender;
-(IBAction) loginPressed:(id)sender;
-(IBAction) settingsButtonPressed:(id)sender;
-(void) doneRetrievingProfile:(NSMutableDictionary *) profile;
-(void) checkLogin;
@end
