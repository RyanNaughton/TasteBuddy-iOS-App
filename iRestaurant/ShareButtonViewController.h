//
//  ShareButtonViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 01/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TakePhoto;

@interface ShareButtonViewController : UIViewController {
    TakePhoto *takePhoto;
}

@property (nonatomic, retain) TakePhoto *takePhoto;

-(void) photoButtonPressed;
- (void) newImageLoaded:(NSDictionary *)dict;
@end
