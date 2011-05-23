//
//  PhotoViewer.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGUIScrollViewImage.h"

@interface PhotoViewer : UIViewController <IGUIScrollViewImageDelegate> {
    IGUIScrollViewImage *svimage;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UILabel *dishNameLabel;
    IBOutlet UILabel *commentLabel;
}


@property (nonatomic, retain) IGUIScrollViewImage *svimage;
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;
@property (nonatomic, retain) IBOutlet UILabel *dishNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *commentLabel;

-(void) setImageLabelsDishName:(NSString *)dishNameString andComment:(NSString *)commentString;
-(void)setupScrollView:(NSArray *)arrayOfPhotos;
-(IBAction) closeButtonPressed;


@end
