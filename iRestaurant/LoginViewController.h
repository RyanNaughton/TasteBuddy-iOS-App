//
//  LoginViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginService.h"

@class AbstractService;

@interface LoginViewController : UIViewController<LoginServiceDelegate> {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIBarItem *cancelButton;
    IBOutlet UIBarItem *loginButton;
    LoginService *loginService;
    AbstractService *serviceToPerformSubsequentRequest;
}

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UIBarItem *cancelButton;
@property (nonatomic, retain) IBOutlet UIBarItem *loginButton;
@property (nonatomic, retain) LoginService *loginService;
@property (nonatomic, retain) AbstractService *serviceToPerformSubsequentRequest;

-(IBAction) cancel;
-(IBAction) login;


@end
