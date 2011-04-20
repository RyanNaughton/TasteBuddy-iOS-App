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
@synthesize phone, phoneButton;

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
        
//        phone = [[UILabel alloc]init];
//        phone.frame = CGRectMake(25, 0, 250, 40);
//        phone.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
//        phone.textAlignment = UITextAlignmentCenter;
//		phone.backgroundColor = [UIColor clearColor];
//		phone.font = [UIFont boldSystemFontOfSize:20];
//        
//        phone.shadowColor = [UIColor whiteColor];
//        phone.shadowOffset = CGSizeMake(0,1);
        
        //[self.contentView addSubview:phone];

    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    phone.text = [NSString stringWithFormat:@"%@", restaurant.phone];
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
