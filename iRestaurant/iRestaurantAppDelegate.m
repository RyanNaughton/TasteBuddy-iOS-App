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
#import "PhotoUploadService.h"
#import "SearchViewController.h"
#import "FavoritesViewController.h"
#import "ProfileTableViewController.h"
#import "SignUpViewController.h"
#import "CoreLocationController.h"
#import "MBProgressHUD.h"
#import "ShareButtonViewController.h"

@implementation iRestaurantAppDelegate

@synthesize window=_window;
@synthesize tabBarController;
@synthesize savedSettingsPath;
@synthesize clcontroller, currentLocation, currentLocationEstablished, showWelcomeBox, sbvc;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [self.window makeKeyAndVisible];
    [self.window addSubview:tabBarController.view];

    [self checkOrCreatePlist];
    
    currentLocationEstablished = NO;
    
    // Current Location defaults to the center of Chicago: State and Washington Street:  41.883333,-87.62786
    currentLocation = [[CLLocation alloc]initWithLatitude:41.883333 longitude:-87.62786];
    [self startGettingLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startLoadingIndicator) name:@"startLoadingIndicator" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopLoadingIndicator) name:@"stopLoadingIndicator" object:nil];
    [self setupHUD];
    
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
    [clcontroller.locMgr stopUpdatingLocation];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    [self startGettingLocation];
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

-(void)startGettingLocation {
    clcontroller = [[CoreLocationController alloc] init];
	clcontroller.delegate = self;
	[clcontroller.locMgr startUpdatingLocation];
}

-(void)updateLocation {
    [clcontroller.locMgr startUpdatingLocation];
}

- (void)locationUpdate:(CLLocation *)location {
    currentLocation = [location retain];
    if (!currentLocationEstablished) {
        currentLocationEstablished = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fireSearch" object:nil];   
        if (showWelcomeBox) {
            showWelcomeBox = FALSE;
            [self displayWelcomeMessage];
        }
    }
    [clcontroller.locMgr stopUpdatingLocation]; 
}

- (void)locationError:(NSError *)error {
    if (!currentLocationEstablished) {
        currentLocationEstablished = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fireSearch" object:nil];
        if (showWelcomeBox) {
            showWelcomeBox = FALSE;
            [self displayWelcomeMessage];
        }
    }
    [clcontroller.locMgr stopUpdatingLocation]; 
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
        //[self displayWelcomeMessage];
        showWelcomeBox = TRUE;
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
    if (![self loggedIn]) {
        LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        lvc.serviceToPerformSubsequentRequest = [service retain];
        lvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        if ([service isKindOfClass:[PhotoUploadService class]]) {
            [self.tabBarController.modalViewController presentModalViewController:lvc animated:YES];
        } else {
            [self.tabBarController presentModalViewController:lvc animated:YES];            
        }
        [lvc release];
    }
}

-(bool) loggedIn {
   return [self readSavedSetting:@"authentication_token"] != nil && ![[self readSavedSetting:@"authentication_token"]isEqualToString:@""];
}

-(IBAction) logout {
    [self setSavedSetting:@"authentication_token" withValue:@""];
    for (UINavigationController *navc in tabBarController.viewControllers) {
        [navc popToRootViewControllerAnimated:NO];
        if([navc.visibleViewController isKindOfClass:[SearchViewController class]]) {
            SearchViewController *svc = (SearchViewController *) navc.visibleViewController; 
            svc.needsToPerformDefaultSearch = YES;
            svc.fakeTermField.text = @"";
            [svc.searchService.jsonDictionary removeObjectForKey:@"auth_token"];
        } else if([navc.visibleViewController isKindOfClass:[FavoritesViewController class]]) {
            //FavoritesViewController *fvc = (FavoritesViewController *) navc.visibleViewController;            
            
        } else if([navc.visibleViewController isKindOfClass:[ProfileTableViewController class]]){
            //ProfileTableViewController *pvc = (ProfileTableViewController *) navc.visibleViewController; 
        }
    } 
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Logged Out" message:@"You have successfully logged out." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
}
-(void) updateAuthentication:(AuthenticationResponse *) authResponse {
    [self setSavedSetting:@"authentication_token" withValue:authResponse.authentication_token];
}

-(void) displayWelcomeMessage {
    UIAlertView *welcomeAlert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:@"TasteBuddy helps you find just the right food! The more you tell us what you like, the better we can help you order with confidence and discover the best hidden gems!" delegate:self cancelButtonTitle:@"Sign me up!"  otherButtonTitles:@"No, not now", nil];
    [welcomeAlert show];
    [welcomeAlert release];
}

- (void)dealloc
{
    [_window release];
    [tabBarController release];
    [savedSettingsPath release];
    [super dealloc];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        SignUpViewController *signUpVC = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
        signUpVC.loginViewController = nil;
        [self.tabBarController presentModalViewController:signUpVC animated:YES];
    }
}

-(void)startLoadingIndicator {
	[HUD show:YES];
}

-(void)stopLoadingIndicator {
	[HUD hide:YES];
}

- (void)setupHUD {
    HUD = [[MBProgressHUD alloc] initWithView:tabBarController.view];
	HUD.labelText = @"Just a sec...";
	HUD.yOffset = -50;	
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
    
    //[tabBarController.view addSubview:HUD];
    HUD.delegate = self;
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController 
{
    //if (tabBarController.selectedIndex == 2) {
    //    [sbvc photoButtonPressed];
    //}
}


@end
