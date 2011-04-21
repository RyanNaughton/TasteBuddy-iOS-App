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
@synthesize menuButton, parentView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *menuButtonImage = [[UIImage imageNamed:@"darkgrey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        [menuButton setBackgroundImage:menuButtonImage forState:UIControlStateNormal];
        [menuButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        menuButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        menuButton.frame = CGRectMake(10, 10, 300, 35);
        [menuButton setTitle:@"Menus" forState:UIControlStateNormal];
        [self.contentView addSubview:menuButton];
        
        UIImageView *addressImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"48-fork-and-knife.png"]];
        addressImage.frame = CGRectMake(22, 20, 15, 15);
        addressImage.alpha = 0.8;
        [self.contentView addSubview:addressImage];
        [addressImage release];
        
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    
}

-(void)menuButtonPressed:(id)sender {
    [parentView loadMenu];
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
