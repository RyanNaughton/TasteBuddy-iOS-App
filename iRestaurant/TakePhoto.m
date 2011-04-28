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

@implementation TakePhoto
@synthesize containerView;

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
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePickerController.modalPresentationStyle = UIModalPresentationPageSheet;

    if (buttonIndex == 0) 
    {
        NSLog(@"take pic");
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    if (buttonIndex == 1) 
    {
        NSLog(@"choose from library");
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
        
    [appDelegate.tabBarController presentModalViewController:imagePickerController animated:YES];
    [imagePickerController release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"image picker finished");
	UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
	
	if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
		NSLog(@"save image");
		UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
	}
    [picker dismissModalViewControllerAnimated:NO];
    [self launchAdditionalDetailsWindowWithImage:image andPicker:picker];
}

-(void)launchAdditionalDetailsWindowWithImage:(UIImage *)image andPicker:(UIImagePickerController *)picker {
    NSLog(@"launchAdditionalDetailsWindowWithImage");
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];    
    
    PhotoShareContainer *photoShareContainer = [[PhotoShareContainer alloc]initWithWhere:@"where" andWhat:@"what" andImage:image];
    photoShareContainer.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    photoShareContainer.modalPresentationStyle = UIModalPresentationPageSheet;
    [appDelegate.tabBarController presentModalViewController:photoShareContainer animated:NO];
    [photoShareContainer release];
}


@end
