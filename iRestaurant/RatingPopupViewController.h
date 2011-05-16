//
//  RatingPopupViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/16/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RatingPopupViewController : UIViewController {
    IBOutlet UIButton *closeButton; 
    IBOutlet UIButton *submitButton; 
}

@property (nonatomic, retain) IBOutlet UIButton *closeButton;
@property (nonatomic, retain) IBOutlet UIButton *submitButton;

-(IBAction)closeButtonPressed:(id)sender;
-(IBAction)submitButtonPressed:(id)sender;
-(void) closeAnimationFinished;

@end
