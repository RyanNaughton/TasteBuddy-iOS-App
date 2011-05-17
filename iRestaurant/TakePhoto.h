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
@class DishViewController;

@interface TakePhoto : NSObject <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIViewController *containerView;
    Restaurant *restaurant;
    MenuItem *menuItem;
    RestaurantViewController *rvc;
    DishViewController *dvc;
    BOOL isForRestaurant;
}

@property (nonatomic, retain) UIViewController *containerView;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) MenuItem *menuItem;
@property (nonatomic, retain) RestaurantViewController *rvc;
@property (nonatomic, retain) DishViewController *dvc;
@property (nonatomic, assign) BOOL isForRestaurant;


-(id)initWithParentViewController:(id)viewController;
-(void)loadPhotoForRestaurant:(Restaurant *)restaurant_passed withView:(RestaurantViewController *)rvc_passed;
-(void)loadPhotoForDish:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant_passed withView:(DishViewController *)dvc_passed;
-(void)launchAdditionalDetailsWindowWithImage:(UIImage *)image andPicker:(UIImagePickerController *)picker;
-(void)loadPhotoForMenuItem:(MenuItem *)menu_item_passed atRestaurant:(Restaurant *)restaurant_passed;

@end
