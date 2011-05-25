//
//  ProfilePhotoDayTopCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "ProfilePhotoDayTopCell.h"


@implementation ProfilePhotoDayTopCell
@synthesize dayLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *topRounding = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top-rounding.png"]];
        topRounding.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
        topRounding.frame = CGRectMake(0, 0, 320, 15);
        [self.contentView addSubview:topRounding];
        [topRounding release];
        
        dayLabel = [[UILabel alloc]init];
        dayLabel.frame = CGRectMake(10, 10, 250, 20);
        dayLabel.textColor = [UIColor darkGrayColor];
        dayLabel.backgroundColor = [UIColor clearColor];
        dayLabel.font = [UIFont systemFontOfSize:14];
        dayLabel.shadowColor = [UIColor whiteColor];
        dayLabel.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:dayLabel];
        [dayLabel release];

    }
    return self;
}

-(void)setDate:(NSString *)date {
    dayLabel.text = [NSString stringWithFormat:@"%@", date];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [dayLabel release];
    [super dealloc];
}

@end
