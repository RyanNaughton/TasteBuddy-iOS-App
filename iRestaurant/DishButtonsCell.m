//
//  DishButtonsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/18/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishButtonsCell.h"


@implementation DishButtonsCell
@synthesize generalInfoButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        generalInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        generalInfoButton.frame = CGRectMake(10, 10, 90, 40);
        [generalInfoButton setBackgroundImage:[UIImage imageNamed:@"grey-button-bg.png"] forState:UIControlStateNormal];
        [generalInfoButton setTitle:@"Restaurant Info" forState:UIControlStateNormal];
        generalInfoButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        generalInfoButton.titleLabel.shadowColor = [UIColor blackColor];
        generalInfoButton.titleLabel.shadowOffset = CGSizeMake(0,1);
        [generalInfoButton addTarget:self action:@selector(generalInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:generalInfoButton];
        
    }
    return self;
}

-(void)generalInfoButtonPressed:(id)sender {
    NSLog(@"generalInfoButtonPressed");
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
