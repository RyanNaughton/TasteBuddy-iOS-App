//
//  iRestaurantAppDelegate.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 12/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractService.h"
#import "CoreLocationController.h"

@class AuthenticationResponse;

@interface iRestaurantAppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate, CoreLocationControllerDelegate> {
    IBOutlet UITabBarController *tabBarController;
    NSString *savedSettingsPath;
    CoreLocationController *CLController;
    CLLocation *currentLocation;
    BOOL currentLocationEstablished;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSString *savedSettingsPath;
@property (nonatomic, retain) CoreLocationController *clcontroller;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, assign) BOOL currentLocationEstablished;

-(void)checkOrCreatePlist;
-(id) readSavedSetting:(NSString *)key;
-(void) setSavedSetting:(NSString *)key withValue:(id)value;

-(void) login:(AbstractService *) service;
-(bool) loggedIn;
-(void) logout;
-(void) updateAuthentication:(AuthenticationResponse *) authResponse;
-(void) displayWelcomeMessage;
-(void) getLocation;

@end
