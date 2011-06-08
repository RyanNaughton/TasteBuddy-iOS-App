//
//  DishRestaurantCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 6/8/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishRestaurantCell.h"

@implementation DishRestaurantCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.shadowColor = [UIColor blackColor];
        self.textLabel.shadowOffset = CGSizeMake(0,1);
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];

        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grey-grad"]];
        
        UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"disclosure-arrow.png"]];
        arrow.contentMode = UIViewContentModeCenter;
        arrow.frame = CGRectMake(0, 0, 34, 34);
        self.accessoryView = arrow;
        self.accessoryView.backgroundColor = [UIColor clearColor];
        //self.backgroundColor = [UIColor darkGrayColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
