//
//  TakePhoto.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Restaurant;
@class MenuItem;
@class RestaurantViewController;

@interface TakePhoto : NSObject <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIViewController *containerView;
    Restaurant *restaurant;
    MenuItem *menuItem;
    RestaurantViewController *parentViewController;
}

@property (nonatomic, retain) UIViewController *containerView;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) MenuItem *menuItem;
@property (nonatomic, retain) RestaurantViewController *parentViewController;

-(id)initWithParentViewController:(RestaurantViewController *)viewController;
-(void)loadPhotoForRestaurant:(Restaurant *)restaurant_passed;
-(void)launchAdditionalDetailsWindowWithImage:(UIImage *)image andPicker:(UIImagePickerController *)picker;
-(void)loadPhotoForMenuItem:(MenuItem *)menu_item_passed atRestaurant:(Restaurant *)restaurant_passed;

@end
