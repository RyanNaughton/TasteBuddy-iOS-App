//
//  RestaurantPhoneCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantPhoneCell.h"
#import "Restaurant.h"

@implementation RestaurantPhoneCell
@synthesize phoneButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *greyButtonImage = [[UIImage imageNamed:@"darkgrey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        [phoneButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
        [phoneButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        phoneButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        phoneButton.frame = CGRectMake(10, 10, 300, 35);
        [self.contentView addSubview:phoneButton];
        
        UIImageView *phoneImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"75-phone.png"]];
        phoneImage.frame = CGRectMake(22, 20, 15, 15);
        phoneImage.alpha = 0.8;
        [self.contentView addSubview:phoneImage];
        [phoneImage release];

    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    [phoneButton setTitle:restaurant.phone forState:UIControlStateNormal];
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
