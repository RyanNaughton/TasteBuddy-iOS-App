//
//  iRestaurantAppDelegate.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 12/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "iRestaurantAppDelegate.h"

#import "Restaurant.h"
#import "LoginViewController.h"
#import "AuthenticationResponse.h"

@implementation iRestaurantAppDelegate


@synthesize window=_window;

@synthesize tabBarController;
@synthesize savedSettingsPath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    [self.window addSubview:tabBarController.view];

    [self checkOrCreatePlist];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(void)checkOrCreatePlist {
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
	NSString *documentsDirectory = [paths objectAtIndex:0]; //2
	savedSettingsPath = [documentsDirectory stringByAppendingPathComponent:@"SavedSettings.plist"]; //3
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if (![fileManager fileExistsAtPath: savedSettingsPath]) //4
	{
		NSString *bundle = [[NSBundle mainBundle] pathForResource:@"SavedSettings" ofType:@"plist"]; //5
		
		[fileManager copyItemAtPath:bundle toPath: savedSettingsPath error:&error]; //6
	}
}

-(id) readSavedSetting:(NSString *)key {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
	NSString *documentsDirectory = [paths objectAtIndex:0]; //2
	savedSettingsPath = [documentsDirectory stringByAppendingPathComponent:@"SavedSettings.plist"]; //3
	
	NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: savedSettingsPath];
	return [savedStock objectForKey:key];
}

-(void) setSavedSetting:(NSString *)key withValue:(id)value {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
	NSString *documentsDirectory = [paths objectAtIndex:0]; //2
	savedSettingsPath = [documentsDirectory stringByAppendingPathComponent:@"SavedSettings.plist"]; //3
	
	NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: savedSettingsPath];
	[data setObject:value forKey:key];
	[data writeToFile: savedSettingsPath atomically:YES];
	[data release];
}


-(void) login:(AbstractService *) service {
    if ( [self readSavedSetting:@"authentication_token"] == nil || [[self readSavedSetting:@"authentication_token"]  isEqualToString:@""]) {
        LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        lvc.serviceToPerformSubsequentRequest = [service retain];
        lvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.tabBarController presentModalViewController:lvc animated:YES];
        [lvc release];
    }
}


-(IBAction) logout {
    [self setSavedSetting:@"authentication_token" withValue:@""];
}
-(void) updateAuthentication:(AuthenticationResponse *) authResponse {
    NSLog(@"Auth Token %@", authResponse.authentication_token);
    [self setSavedSetting:@"authentication_token" withValue:authResponse.authentication_token];
}

- (void)dealloc
{
    [_window release];
    [tabBarController release];
    [savedSettingsPath release];
    [super dealloc];
}

@end
