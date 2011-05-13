//
//  PhotoViewer.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IGUIScrollViewImage;

@interface PhotoViewer : UIViewController {
    IGUIScrollViewImage *svimage;
    IBOutlet UINavigationItem *navItem;
}

@property (nonatomic, retain) IGUIScrollViewImage *svimage;
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;

-(void)setupScrollView:(NSArray *)arrayOfURLStrings;
-(IBAction) closeButtonPressed;

@end
