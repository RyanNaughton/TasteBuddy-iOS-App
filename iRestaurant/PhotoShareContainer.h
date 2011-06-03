//
//  PhotoShareContainer.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoUploadService.h"
@class RestaurantViewController;
@class DishViewController;
@class ShareButtonViewController;

@interface PhotoShareContainer : UIViewController <UITextFieldDelegate, PhotoUploadServiceDelegate, NSXMLParserDelegate> {
    IBOutlet UIBarButtonItem *cancelButton;
    IBOutlet UIBarButtonItem *submitButton;
    IBOutlet UIImageView *imageView;
    
    NSString *what;
    NSString *where;
    UIImage *image;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UITextField *whereTextField;
    IBOutlet UITextField *whatTextField;
    IBOutlet UITextField *commentsTextField;
    
    IBOutlet UILabel *whereLabel;
    IBOutlet UILabel *whatLabel;
    IBOutlet UILabel *commentsLabel;
    
    IBOutlet UISwitch *facebookSwitch;
    
    NSString *restaurant;
    NSString *menuItem;
    IBOutlet UINavigationItem *navItem;

    BOOL isForRestaurant;
    RestaurantViewController *rvc;
    DishViewController *dvc;
    ShareButtonViewController *tab;
    BOOL photoSubmitted;
    
    NSString *photoPurpose;
    NSString *temp;
    NSMutableArray *whereAutocompleteArray;
    
    IBOutlet UIButton *whereButton;
    IBOutlet UIButton *whatButton;
    
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *submitButton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) NSString *what;
@property (nonatomic, retain) NSString *where;
@property (nonatomic, retain) UIImage *image;

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *whereTextField;
@property (nonatomic, retain) IBOutlet UITextField *whatTextField;
@property (nonatomic, retain) IBOutlet UITextField *commentsTextField;

@property (nonatomic, retain) IBOutlet UILabel *whereLabel;
@property (nonatomic, retain) IBOutlet UILabel *whatLabel;
@property (nonatomic, retain) IBOutlet UILabel *commentsLabel;

@property (nonatomic, retain) IBOutlet UISwitch *facebookSwitch;

@property (nonatomic, retain) NSString *restaurant;
@property (nonatomic, retain) NSString *menuItem;

@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;

@property (nonatomic, retain) RestaurantViewController *rvc;
@property (nonatomic, retain) DishViewController *dvc;
@property (nonatomic, retain) ShareButtonViewController *tab;
@property (nonatomic, assign) BOOL isForRestaurant;
@property (nonatomic, assign) BOOL photoSubmitted;

@property (nonatomic, retain) NSString *photoPurpose;
@property (nonatomic, retain) NSString *temp;
@property (nonatomic, retain) NSMutableArray *whereAutocompleteArray;

@property (nonatomic, retain) IBOutlet UIButton *whereButton;
@property (nonatomic, retain) IBOutlet UIButton *whatButton;

- (id)initWithWhere:(NSString *)where_passed andWhat:(NSString *)what_passed andImage:(UIImage *)image_passed andRestaurantId:(NSString *)restaurant_id_passed andMenuItemId:(NSString *) menu_item_id_passed;
-(IBAction) cancelButtonPressed:(id)sender;
-(void) submitAction;
-(void) imageLoadingDone:(NSDictionary *)dict;
-(void) shareOnFacebook;
-(void) shareOnTwitter;
-(IBAction) whereButtonPressed;
-(IBAction) whatButtonPressed;

@end
