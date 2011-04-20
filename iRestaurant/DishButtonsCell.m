//
//  DishButtonsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/18/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishButtonsCell.h"
#import "Restaurant.h"

@implementation DishButtonsCell
@synthesize generalInfoButton, bookmarkItButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        generalInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        generalInfoButton.frame = CGRectMake(10, 10, 135, 40);
                
        UIImage *generalInfoButtonImage = [[UIImage imageNamed:@"grey-button-bg.png"] stretchableImageWithLeftCapWidth:20.0 topCapHeight:20.0];
        
        [generalInfoButton setBackgroundImage:generalInfoButtonImage forState:UIControlStateNormal];
        [generalInfoButton setTitle:@"Restaurant Info" forState:UIControlStateNormal];
        generalInfoButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        generalInfoButton.titleLabel.shadowColor = [UIColor blackColor];
        generalInfoButton.titleLabel.shadowOffset = CGSizeMake(0,1);
        [generalInfoButton addTarget:self action:@selector(generalInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:generalInfoButton];

        
        bookmarkItButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bookmarkItButton.frame = CGRectMake(155, 10, 135, 40);
        
        UIImage *bookmarkItButtonImage = [[UIImage imageNamed:@"grey-button-bg.png"] stretchableImageWithLeftCapWidth:20.0 topCapHeight:20.0];
        
        [bookmarkItButton setBackgroundImage:bookmarkItButtonImage forState:UIControlStateNormal];
        [bookmarkItButton setTitle:@"Bookmark It!" forState:UIControlStateNormal];
        bookmarkItButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        bookmarkItButton.titleLabel.shadowColor = [UIColor blackColor];
        bookmarkItButton.titleLabel.shadowOffset = CGSizeMake(0,1);
        [bookmarkItButton addTarget:self action:@selector(bookmarkItButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bookmarkItButton];
        
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant_passed {
    [generalInfoButton setTitle:[NSString stringWithFormat:@"%@ Info", restaurant_passed.name] forState:UIControlStateNormal];
}

-(void)generalInfoButtonPressed:(id)sender {
    NSLog(@"generalInfoButtonPressed");
}

-(void)bookmarkItButtonPressed:(id)sender {
    NSLog(@"bookmarkItButtonPressed");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{   
    [generalInfoButton release];
    [bookmarkItButton release];
    [super dealloc];
}

@end
