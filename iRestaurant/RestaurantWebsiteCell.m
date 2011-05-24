//
//  RestaurantWebsiteCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantWebsiteCell.h"
#import "Restaurant.h"
#import "RestaurantViewController.h"

@implementation RestaurantWebsiteCell
@synthesize websiteButton, restaurantViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andRestaruantController:(RestaurantViewController *)restaurantViewControllerPassed
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;

        restaurantViewController = [restaurantViewControllerPassed retain];

        websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [websiteButton setTitle:@"Visit Restaurant Website" forState:UIControlStateNormal];
        [websiteButton addTarget:restaurantViewController action:@selector(websiteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *greyButtonImage = [[UIImage imageNamed:@"darkgrey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        [websiteButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
        [websiteButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        websiteButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        websiteButton.frame = CGRectMake(10, 0, 300, 35);
        [self.contentView addSubview:websiteButton];
        self.selectionStyle = UITableViewCellEditingStyleNone;
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
    [restaurantViewController release];
    [super dealloc];
}

@end
