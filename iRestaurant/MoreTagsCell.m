//
//  MoreTagsCell.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 26/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MoreTagsCell.h"


@implementation MoreTagsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.text = @"More tags...";
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
