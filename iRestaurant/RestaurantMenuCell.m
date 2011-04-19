//
//  RestaurantMenuCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantMenuCell.h"
#import "Restaurant.h"
#import "RestaurantViewController.h"

@implementation RestaurantMenuCell
@synthesize lunchMenuButton, dinnerMenuButton, bookmarkItButton, parentView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        lunchMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lunchMenuButton.frame = CGRectMake(10, 10, 90, 40);
        [lunchMenuButton setBackgroundImage:[UIImage imageNamed:@"grey-button-bg.png"] forState:UIControlStateNormal];
        [lunchMenuButton setTitle:@"Lunch Menu" forState:UIControlStateNormal];
        lunchMenuButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        lunchMenuButton.titleLabel.shadowColor = [UIColor blackColor];
        lunchMenuButton.titleLabel.shadowOffset = CGSizeMake(0,1);
        [lunchMenuButton addTarget:self action:@selector(lunchMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:lunchMenuButton];
        
        dinnerMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dinnerMenuButton.frame = CGRectMake(105, 10, 90, 40);
        //[dinnerMenuButton setBackgroundColor:[UIColor clearColor]];
        [dinnerMenuButton setBackgroundImage:[UIImage imageNamed:@"grey-button-bg.png"] forState:UIControlStateNormal];
        //[dinnerMenuButton setBackgroundImage:[UIImage imageNamed:@"blue-btn-70.png"] forState:UIControlStateNormal];
        [dinnerMenuButton setTitle:@"Dinner Menu" forState:UIControlStateNormal];
        dinnerMenuButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        dinnerMenuButton.titleLabel.shadowColor = [UIColor blackColor];
        dinnerMenuButton.titleLabel.shadowOffset = CGSizeMake(0,1);
        [dinnerMenuButton addTarget:self action:@selector(dinnerMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:dinnerMenuButton];
        
        bookmarkItButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bookmarkItButton.frame = CGRectMake(200, 10, 90, 40);
        [bookmarkItButton setBackgroundImage:[UIImage imageNamed:@"grey-button-bg.png"] forState:UIControlStateNormal];
        [bookmarkItButton setTitle:@"Bookmark It!" forState:UIControlStateNormal];
        bookmarkItButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        bookmarkItButton.titleLabel.shadowColor = [UIColor blackColor];
        bookmarkItButton.titleLabel.shadowOffset = CGSizeMake(0,1);
        [bookmarkItButton addTarget:self action:@selector(bookmarkItButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bookmarkItButton];

        
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    
}

-(void)lunchMenuButtonPressed:(id)sender {
    NSLog(@"lunch menu button pressed");
    [parentView loadLunchMenu];
}

-(void)dinnerMenuButtonPressed:(id)sender {
    NSLog(@"dinner menu button pressed");
    [parentView loadDinnerMenu];
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
//    [lunchMenuButton release];
//    [dinnerMenuButton release];
//    [bookmarkItButton release];
    [super dealloc];
}

@end
