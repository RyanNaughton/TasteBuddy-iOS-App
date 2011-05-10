//
//  iRestaurantAppDelegate.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 12/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractService.h"

@class AuthenticationResponse;

@interface iRestaurantAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UITabBarController *tabBarController;
    NSString *savedSettingsPath;
    AuthenticationResponse *authenticationResponse;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSString *savedSettingsPath;
@property (nonatomic, retain) AuthenticationResponse *authenticationResponse;

-(void)checkOrCreatePlist;
-(id) readSavedSetting:(NSString *)key;
-(void) setSavedSetting:(NSString *)key withValue:(id)value;

-(void) login:(AbstractService *) service;
-(void) logout;
-(void) updateAuthentication:(AuthenticationResponse *) authResponse;

@end
