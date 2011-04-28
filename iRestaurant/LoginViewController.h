//
//  LoginViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIBarItem *cancelButton;
    IBOutlet UIBarItem *loginButton;
}

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UIBarItem *cancelButton;
@property (nonatomic, retain) IBOutlet UIBarItem *loginButton;

-(IBAction) cancel;
-(IBAction) login;


@end
