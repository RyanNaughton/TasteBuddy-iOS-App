//
//  RestaurantAddressCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantAddressCell.h"
#import "Restaurant.h"

@implementation RestaurantAddressCell
@synthesize address_1, address_2, neighborhood, addressButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *addressButtonImage = [[UIImage imageNamed:@"darkgrey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        [addressButton setBackgroundImage:addressButtonImage forState:UIControlStateNormal];
        [addressButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        addressButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        addressButton.frame = CGRectMake(10, 10, 300, 35);
        [self.contentView addSubview:addressButton];
        
        UIImageView *addressImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"74-location.png"]];
        addressImage.frame = CGRectMake(22, 20, 15, 15);
        addressImage.alpha = 0.8;
        [self.contentView addSubview:addressImage];
        [addressImage release];


//        address_1 = [[UILabel alloc]init];
//        address_1.frame = CGRectMake(25, 5, 250, 12);
//        address_1.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
//        address_1.textAlignment = UITextAlignmentCenter;
//		address_1.backgroundColor = [UIColor clearColor];
//		address_1.font = [UIFont systemFontOfSize:12];
//        address_1.shadowColor = [UIColor whiteColor];
//        address_1.shadowOffset = CGSizeMake(0,1);
//        [self.contentView addSubview:address_1];
//
//        address_2 = [[UILabel alloc]init];
//        address_2.frame = CGRectMake(25, 17, 250, 12);
//        address_2.textAlignment = UITextAlignmentCenter;
//        address_2.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
//		address_2.backgroundColor = [UIColor clearColor];
//		address_2.font = [UIFont systemFontOfSize:12];
//        address_2.shadowColor = [UIColor whiteColor];
//        address_2.shadowOffset = CGSizeMake(0,1);
//        [self.contentView addSubview:address_2];
//        
//        neighborhood = [[UILabel alloc]init];
//        neighborhood.frame = CGRectMake(25, 29, 250, 12);
//        neighborhood.textAlignment = UITextAlignmentCenter;
//        neighborhood.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
//		neighborhood.backgroundColor = [UIColor clearColor];
//		neighborhood.font = [UIFont boldSystemFontOfSize:12];
//        neighborhood.shadowColor = [UIColor whiteColor];
//        neighborhood.shadowOffset = CGSizeMake(0,1);
//        [self.contentView addSubview:neighborhood];

    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    [addressButton setTitle:restaurant.address_1 forState:UIControlStateNormal];
    
    address_1.text = [NSString stringWithFormat:@"%@", restaurant.address_1];
    address_2.text = [NSString stringWithFormat:@"%@", restaurant.address_2];
    neighborhood.text = [NSString stringWithFormat:@"Neighborhood: %@", restaurant.neighborhood];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [addressButton release];
    [address_1 release];
    [address_2 release];
    [neighborhood release];
    [super dealloc];
}

@end
