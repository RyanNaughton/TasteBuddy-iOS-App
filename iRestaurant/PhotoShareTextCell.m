//
//  PhotoShareTextCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "PhotoShareTextCell.h"


@implementation PhotoShareTextCell
@synthesize textField, label, outerScroll, currentTextFieldRect;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, 75, 40)];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = UITextAlignmentRight;
        
        [self.contentView addSubview:label];
        
        textField = [[UITextField alloc]initWithFrame:CGRectMake(95, 12, 180, 30)];
        textField.delegate = self;
        textField.font = [UIFont systemFontOfSize:15];
        
        
        [self.contentView addSubview:textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
    
    //[outerScroll scrollRectToVisible:rect animated:YES];
    
    // Configure the view for the selected state
}

- (void)textFieldDidBeginEditing:(UITextField *)textField_passed {
    [outerScroll scrollRectToVisible:currentTextFieldRect animated:YES];
}



- (void)dealloc
{
    [label release];
    [textField release];
    [super dealloc];
}

@end
