//
//  DishCommentsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/21/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishCommentsCell.h"
#import "MenuItem.h"

@implementation DishCommentsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)loadMenuItem:(MenuItem *)menu_item {
    UIImageView *topRounding = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top-rounding.png"]];
    topRounding.frame = CGRectMake(0, 10, 320, 15);
    [self.contentView addSubview:topRounding];
    [topRounding release];
    
    UILabel *tagsLabel = [[UILabel alloc]init];
    tagsLabel.frame = CGRectMake(10, 25, 120, 15);
    tagsLabel.textColor = [UIColor blackColor];
    tagsLabel.backgroundColor = [UIColor clearColor];
    tagsLabel.font = [UIFont boldSystemFontOfSize:16];
    tagsLabel.shadowColor = [UIColor whiteColor];
    tagsLabel.shadowOffset = CGSizeMake(0,1);
    tagsLabel.text = @"Comments";
    [self.contentView addSubview:tagsLabel];
    [tagsLabel release];
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
