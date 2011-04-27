//
//  TakePhoto.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TakePhoto.h"
#import "iRestaurantAppDelegate.h"

@implementation TakePhoto


-(void) cameraButtonPressed:(id)sender {
    NSLog(@"camera button pressed");
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Choose Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Use Photo Library", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [popupQuery showInView:appDelegate.tabBarController.view];
    [popupQuery release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"index; %i", buttonIndex);
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (buttonIndex == 0) 
    {
        NSLog(@"take pic");
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePickerController.modalPresentationStyle = UIModalPresentationPageSheet;
        [appDelegate.tabBarController presentModalViewController:imagePickerController animated:YES];
        [imagePickerController release];
    }
    if (buttonIndex == 1) 
    {
        NSLog(@"choose from library");
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePickerController.modalPresentationStyle = UIModalPresentationPageSheet;
        [appDelegate.tabBarController presentModalViewController:imagePickerController animated:YES];
        [imagePickerController release];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"image picker finished");
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	
	if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
		NSLog(@"save image");
		UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
	}
    [picker dismissModalViewControllerAnimated:YES];
}



@end
