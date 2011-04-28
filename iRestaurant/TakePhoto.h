//
//  TakePhoto.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TakePhoto : NSObject <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIViewController *containerView;
}

@property (nonatomic, retain) UIViewController *containerView;

-(void) cameraButtonPressed:(id)sender;
-(void)launchAdditionalDetailsWindowWithImage:(UIImage *)image andPicker:(UIImagePickerController *)picker;

@end
