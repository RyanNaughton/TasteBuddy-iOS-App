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

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet iRestaurantViewController *viewController;

@end
