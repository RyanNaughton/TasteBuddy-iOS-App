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

@implementation TakePhoto
@synthesize containerView, restaurant, menuItem;

-(void)loadPhotoForRestaurant:(Restaurant *)restaurant_passed {
    restaurant = [restaurant_passed retain];
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Choose Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Use Photo Library", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [popupQuery showInView:appDelegate.tabBarController.view];
    [popupQuery release];
}

-(void)loadPhotoForMenuItem:(MenuItem *)menu_item_passed atRestaurant:(Restaurant *)restaurant_passed {
    menuItem = [menu_item_passed retain];
    restaurant = [restaurant_passed retain];
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Choose Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Use Photo Library", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [popupQuery showInView:appDelegate.tabBarController.view];
    [popupQuery release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePickerController.modalPresentationStyle = UIModalPresentationPageSheet;

    if (buttonIndex == 0) 
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    if (buttonIndex == 1) 
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
        
    [appDelegate.tabBarController presentModalViewController:imagePickerController animated:YES];
    [imagePickerController release];
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
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];    
    
    PhotoShareContainer *photoShareContainer = [[PhotoShareContainer alloc]initWithWhere:restaurant.name andWhat:@"" andImage:image];
    photoShareContainer.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    photoShareContainer.modalPresentationStyle = UIModalPresentationPageSheet;
    [appDelegate.tabBarController presentModalViewController:photoShareContainer animated:YES];
    [photoShareContainer release];
}

-(void)dealloc {
    [menuItem release];
    [restaurant release];
    [super dealloc];
}

@end
