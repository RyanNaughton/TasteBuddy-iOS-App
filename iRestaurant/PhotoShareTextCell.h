//
//  PhotoShareTextCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoShareTextCell : UITableViewCell <UITextFieldDelegate> {
    UITextField *textField;
    UILabel *label;
    UIScrollView *outerScroll;
    CGRect currentTextFieldRect;
}

@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIScrollView *outerScroll;
@property (nonatomic, assign) CGRect currentTextFieldRect;

@end
