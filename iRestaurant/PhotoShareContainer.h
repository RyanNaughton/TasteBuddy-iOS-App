//
//  PhotoShareContainer.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoUploadService.h"

@interface PhotoShareContainer : UIViewController <UITextFieldDelegate, PhotoUploadServiceDelegate> {
    IBOutlet UIBarButtonItem *cancelButton;
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

}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton;
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

- (id)initWithWhere:(NSString *)where_passed andWhat:(NSString *)what_passed andImage:(UIImage *)image_passed andRestaurantId:(NSString *)restaurant_id_passed andMenuItemId:(NSString *) menu_item_id_passed;
-(IBAction) cancelButtonPressed:(id)sender;

@end
