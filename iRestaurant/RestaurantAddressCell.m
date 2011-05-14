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
@synthesize neighborhood, addressButton, restaurant;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addressButton addTarget:self action:@selector(addressButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
        self.selectionStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant_passed 
{
    restaurant = [restaurant_passed retain];
    UILabel *addressButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 240, 35)];
    addressButtonLabel.adjustsFontSizeToFitWidth = TRUE;
    addressButtonLabel.textColor = [UIColor darkGrayColor];
    addressButtonLabel.backgroundColor = [UIColor clearColor];
    addressButtonLabel.font = [UIFont boldSystemFontOfSize:16];
    addressButtonLabel.text = restaurant_passed.address_1;
    addressButtonLabel.textAlignment = UITextAlignmentCenter;
    [addressButton addSubview:addressButtonLabel];
    [addressButtonLabel release];
    
    neighborhood.text = [NSString stringWithFormat:@"Neighborhood: %@", restaurant_passed.neighborhood];
}

-(void)addressButtonPressed:(id)sender {
    NSString *addressString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@", restaurant.address_1, restaurant.address_2, restaurant.city_town, restaurant.state_province, restaurant.postal_code, restaurant.country];
    addressString = [addressString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *requestString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@&z=15", addressString];
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:requestString]];	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [restaurant release];
    [neighborhood release];
    [super dealloc];
}

@end
