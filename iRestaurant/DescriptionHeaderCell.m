//
//  DescriptionHeaderCell.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 20/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DescriptionHeaderCell.h"

@implementation DescriptionHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UIImageView *topRounding = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top-rounding.png"]];
        topRounding.frame = CGRectMake(0, 10, 320, 15);
        [self.contentView addSubview:topRounding];
        [topRounding release];
        
        UILabel *headerLabel = [[UILabel alloc]init];
        headerLabel.frame = CGRectMake(10, 25, 120, 15);
        headerLabel.textColor = [UIColor blackColor];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:14];
        headerLabel.shadowColor = [UIColor whiteColor];
        headerLabel.shadowOffset = CGSizeMake(0,1);
        headerLabel.text = @"Description";
        [self.contentView addSubview:headerLabel];
        [headerLabel release];
        
    }
    return self;
}
@end
