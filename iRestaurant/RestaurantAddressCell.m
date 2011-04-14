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
@synthesize address_1, address_2, neighborhood;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        address_1 = [[UILabel alloc]init];
        address_1.frame = CGRectMake(35, 5, 250, 12);
        address_1.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
        address_1.textAlignment = UITextAlignmentCenter;
		address_1.backgroundColor = [UIColor clearColor];
		address_1.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:address_1];

        address_2 = [[UILabel alloc]init];
        address_2.frame = CGRectMake(35, 17, 250, 12);
        address_2.textAlignment = UITextAlignmentCenter;
        address_2.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		address_2.backgroundColor = [UIColor clearColor];
		address_2.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:address_2];
        
        neighborhood = [[UILabel alloc]init];
        neighborhood.frame = CGRectMake(35, 29, 250, 12);
        neighborhood.textAlignment = UITextAlignmentCenter;
        neighborhood.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		neighborhood.backgroundColor = [UIColor clearColor];
		neighborhood.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:neighborhood];

        
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
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
    [address_1 release];
    [address_2 release];
    [neighborhood release];
    [super dealloc];
}

@end
