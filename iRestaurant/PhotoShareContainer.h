//
//  PhotoShareContainer.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoShareViewController;

@interface PhotoShareContainer : UIViewController <UITextFieldDelegate> {
    PhotoShareViewController *photoShareViewController;
    IBOutlet UITableView *tableView;
    IBOutlet UIBarButtonItem *cancelButton;
    IBOutlet UIImageView *imageView;
    
    NSString *what;
    NSString *where;
    UIImage *image;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UITextField *whereTextField;
    IBOutlet UITextField *whatTextField;
    IBOutlet UITextField *commentsTextField;
    IBOutlet UISwitch *facebookSwitch;
    
}

@property (nonatomic, retain) PhotoShareViewController *photoShareViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) NSString *what;
@property (nonatomic, retain) NSString *where;
@property (nonatomic, retain) UIImage *image;

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *whereTextField;
@property (nonatomic, retain) IBOutlet UITextField *whatTextField;
@property (nonatomic, retain) IBOutlet UITextField *commentsTextField;
@property (nonatomic, retain) IBOutlet UISwitch *facebookSwitch;

- (id)initWithWhere:(NSString *)where_passed andWhat:(NSString *)what_passed andImage:(UIImage *)image_passed;

-(IBAction) cancelButtonPressed:(id)sender;

@end