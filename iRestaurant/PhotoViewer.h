//
//  PhotoViewer.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "IGUIScrollViewImage.h"

@interface PhotoViewer : UIViewController <IGUIScrollViewImageDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    IGUIScrollViewImage *svimage;
    IBOutlet UILabel *dishNameLabel;
    IBOutlet UILabel *commentLabel;
    NSArray *arrayOfPhotos;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UIBarButtonItem *closeButton;
}


@property (nonatomic, retain) IGUIScrollViewImage *svimage;
@property (nonatomic, retain) IBOutlet UILabel *dishNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *commentLabel;
@property (nonatomic, retain) NSArray *arrayOfPhotos;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *closeButton;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;

-(void) setImageLabelsDishName:(NSString *)dishNameString andComment:(NSString *)commentString;
-(void)setupScrollView:(NSArray *)arrayOfPhotos_passed;
-(IBAction) closeButtonPressed;
-(IBAction) reportAbuseButtonPressed:(id)sender;
-(void) launchEmailFeedbackForPictureAtIndex:(int)index;


@end
