//
//  DealsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/31/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DealsCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation DealsCell
@synthesize dealImageView, dealLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        dealImageView = [[UIImageView alloc]init];
        dealImageView.contentMode = UIViewContentModeScaleAspectFill;
        dealImageView.clipsToBounds = YES;
        dealImageView.frame = CGRectMake(2, 2, 65, 65);
        dealImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        dealImageView.layer.borderWidth = 1;
        [self.contentView addSubview:dealImageView];
        
        dealLabel = [[UILabel alloc]init];
        dealLabel.frame = CGRectMake(75, 5, 155, 65);
        dealLabel.numberOfLines = 3;
        dealLabel.adjustsFontSizeToFitWidth = FALSE;
        dealLabel.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		dealLabel.backgroundColor = [UIColor clearColor];
		dealLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:dealLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [dealImageView release];
    [dealLabel release];
    [super dealloc];
}

@end
