//
//  SubCategoryCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/9/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SubCategoryCell.h"


@implementation SubCategoryCell
@synthesize name, count;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(40, 0, 190, 44);
        name.adjustsFontSizeToFitWidth = TRUE;
        name.textAlignment = UITextAlignmentLeft;
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:0.7];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:15];
        name.shadowColor = [UIColor whiteColor];
        name.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:name];
        
        count = [[UILabel alloc]init];
        count.frame = CGRectMake(240, 0, 30, 44);
        count.adjustsFontSizeToFitWidth = TRUE;
        count.textAlignment = UITextAlignmentRight;
        count.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:0.7];
		count.backgroundColor = [UIColor clearColor];
		count.font = [UIFont boldSystemFontOfSize:12];
        count.shadowColor = [UIColor whiteColor];
        count.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:count];
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
    [super dealloc];
}

@end
