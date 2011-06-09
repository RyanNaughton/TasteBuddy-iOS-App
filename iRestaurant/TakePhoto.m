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
@synthesize containerView, restaurant, menuItem, rvc, dvc, tab, photoPurpose;

-(id)initWithParentViewController:(id)viewController {
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)loadPhotoForShareTabWithView:(ShareButtonViewController *)tab_passed {
    tab = [tab_passed retain];
    //restaurant = [restaurant_passed retain];
    //menuItem.name = @"";
    //rvc = rvc_passed;
    //isForRestaurant = TRUE;
    photoPurpose = @"tab";
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Choose Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Use Photo Library", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    popupQuery.delegate = self;
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [popupQuery showFromTabBar:appDelegate.tabBarController.tabBar];
    [popupQuery release];
}

-(void)loadPhotoForRestaurant:(Restaurant *)restaurant_passed withView:(RestaurantViewController *)rvc_passed {
    restaurant = [restaurant_passed retain];
    menuItem.name = @"";
    rvc = rvc_passed;
    photoPurpose = @"restaurant";
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Choose Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Use Photo Library", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    popupQuery.delegate = self;
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [popupQuery showFromTabBar:appDelegate.tabBarController.tabBar];
    [popupQuery release];
}

-(void)loadPhotoForDish:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant_passed withView:(DishViewController *)dvc_passed {
    restaurant = [restaurant_passed retain];
    menuItem = [menu_item_passed retain];
    dvc = dvc_passed;
    photoPurpose = @"dish";
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
        if ( (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]))
        {
            UIAlertView *noCamera = [[UIAlertView alloc] initWithTitle:@"Device Error" message:@"You iOS device doesn't have a camera." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil ];
            [noCamera show];
            [noCamera release];
        } else {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePickerController.modalPresentationStyle = UIModalPresentationPageSheet;

        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [appDelegate.tabBarController presentModalViewController:imagePickerController animated:YES];
        [imagePickerController release];
        }

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
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    PhotoShareContainer *photoShareContainer = [[PhotoShareContainer alloc]initWithWhere:restaurant.name andWhat:menuItem.name andImage:image andRestaurantId:restaurant._id andMenuItemId:menuItem._id]; 
    
    if ([photoPurpose isEqualToString:@"restaurant"]) {
        photoShareContainer.rvc = rvc;
    } else if ([photoPurpose isEqualToString:@"dish"]) {
        photoShareContainer.dvc = dvc;
    } else if ([photoPurpose isEqualToString:@"tab"]) {
        photoShareContainer.tab = tab;
    }
    
    photoShareContainer.photoPurpose = photoPurpose;
    photoShareContainer.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    photoShareContainer.modalPresentationStyle = UIModalPresentationPageSheet;
    [appDelegate.tabBarController presentModalViewController:photoShareContainer animated:YES];
    [photoShareContainer release];
}

-(void)dealloc {
    //[parentViewController release];
    [menuItem release];
    [restaurant release];
    [super dealloc];
}

@end
