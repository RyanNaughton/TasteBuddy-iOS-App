//
//  RestaurantWebsiteCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantWebsiteCell.h"
#import "Restaurant.h"

@implementation RestaurantWebsiteCell
@synthesize websiteButton, restaurant;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [websiteButton setTitle:@"Visit Restaurant Website" forState:UIControlStateNormal];
        [websiteButton addTarget:self action:@selector(websiteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *greyButtonImage = [[UIImage imageNamed:@"darkgrey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        [websiteButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
        [websiteButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        websiteButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        websiteButton.frame = CGRectMake(10, 10, 300, 35);
        [self.contentView addSubview:websiteButton];

    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant_passed 
{
    restaurant = [restaurant_passed retain];
}

-(void) websiteButtonPressed:(id)sender {
    NSString *websiteString = [NSString stringWithFormat:@"%@", restaurant.website_url];
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:websiteString]];	
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
