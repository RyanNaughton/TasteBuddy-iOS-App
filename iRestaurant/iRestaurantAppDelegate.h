//
//  iRestaurantAppDelegate.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 12/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iRestaurantViewController;

@interface iRestaurantAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UITabBarController *tabBarController;
    NSString *savedSettingsPath;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSString *savedSettingsPath;

-(void)checkOrCreatePlist;
-(id) readSavedSetting:(NSString *)key;
-(void) setSavedSetting:(NSString *)key withValue:(id)value;

-(void) login;

@end
