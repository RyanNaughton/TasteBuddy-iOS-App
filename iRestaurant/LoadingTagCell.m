//
//  LoadingTagCell.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 25/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "LoadingTagCell.h"


@implementation LoadingTagCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.text = @"Loading tags...";
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.textColor = [UIColor grayColor];
        UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [act startAnimating];
        self.accessoryView = act;
        [act release];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
