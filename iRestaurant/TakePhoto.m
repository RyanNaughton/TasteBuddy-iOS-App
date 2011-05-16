//
//  TakePhoto.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TakePhoto.h"
#import "iRestaurantAppDelegate.h"
#import "PhotoShareContainer.h"
#import "Restaurant.h"
#import "MenuItem.h"
#import "RestaurantViewController.h"

@implementation TakePhoto
@synthesize containerView, restaurant, menuItem, parentViewController;

-(id)initWithParentViewController:(id)viewController {
    self = [super init];
    if (self) {
        parentViewController = [viewController retain];
    }
    return self;
}

-(void)loadPhotoForRestaurant:(Restaurant *)restaurant_passed {
    restaurant = [restaurant_passed retain];
    menuItem.name = @"";
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Choose Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Use Photo Library", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    popupQuery.delegate = self;
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [popupQuery showFromTabBar:appDelegate.tabBarController.tabBar];
    [popupQuery release];
}

-(void)loadPhotoForDish:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant_passed {
    restaurant = [restaurant_passed retain];
    menuItem = [menu_item_passed retain];
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Choose Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Use Photo Library", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    popupQuery.delegate = self;
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [popupQuery showFromTabBar:appDelegate.tabBarController.tabBar];
    [popupQuery release];
}

-(void)loadPhotoForMenuItem:(MenuItem *)menu_item_passed atRestaurant:(Restaurant *)restaurant_passed {
    menuItem = [menu_item_passed retain];
    restaurant = [restaurant_passed retain];
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Choose Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Use Photo Library", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    popupQuery.delegate = self;
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [popupQuery showFromTabBar:appDelegate.tabBarController.tabBar];
    [popupQuery release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];

   
    if (buttonIndex == 0) 
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePickerController.modalPresentationStyle = UIModalPresentationPageSheet;

        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [appDelegate.tabBarController presentModalViewController:imagePickerController animated:YES];
        [imagePickerController release];

    }
    if (buttonIndex == 1) 
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePickerController.modalPresentationStyle = UIModalPresentationPageSheet;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
        [appDelegate.tabBarController presentModalViewController:imagePickerController animated:YES];
        [imagePickerController release];

    }        
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
	
	if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
		// Save Image to Photo Library on Device
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
	}
    [picker dismissModalViewControllerAnimated:NO];
    [self launchAdditionalDetailsWindowWithImage:image andPicker:picker];
}

-(void)launchAdditionalDetailsWindowWithImage:(UIImage *)image andPicker:(UIImagePickerController *)picker {
    
    PhotoShareContainer *photoShareContainer = [[PhotoShareContainer alloc]initWithWhere:restaurant.name andWhat:menuItem.name andImage:image andRestaurantId:restaurant._id andMenuItemId:menuItem._id];
    photoShareContainer.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    photoShareContainer.modalPresentationStyle = UIModalPresentationPageSheet;
    [parentViewController presentModalViewController:photoShareContainer animated:YES];
    [photoShareContainer release];
}

-(void)dealloc {
    [parentViewController release];
    [menuItem release];
    [restaurant release];
    [super dealloc];
}

@end
