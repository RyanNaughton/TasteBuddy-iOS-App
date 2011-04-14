//
//  RestaurantSearchCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantSearchCell.h"
#import "Restaurant.h"

@implementation RestaurantSearchCell
@synthesize imageView, name, tags, addressLine1, addressLine2, distance;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code  
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"restaurant-icon.gif"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(7, 7, 80, 80);
        [self.contentView addSubview:imageView];
        
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(100, 7, 180, 20);
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:name];
                
        tags = [[UILabel alloc]init];
        tags.frame = CGRectMake(100, 25, 180, 15);
        tags.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		tags.backgroundColor = [UIColor clearColor];
		UIFont *italicFont = [UIFont fontWithName:@"Helvetica-Oblique" size:12];
        tags.font = italicFont;
        [self.contentView addSubview:tags];
        
        addressLine1 = [[UILabel alloc]init];
        addressLine1.frame = CGRectMake(100, 55, 180, 15);
        addressLine1.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		addressLine1.backgroundColor = [UIColor clearColor];
		addressLine1.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:addressLine1];
        
        addressLine2 = [[UILabel alloc]init];
        addressLine2.frame = CGRectMake(100, 70, 180, 15);
        addressLine2.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		addressLine2.backgroundColor = [UIColor clearColor];
		addressLine2.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:addressLine2];

        distance = [[UILabel alloc]init];
        distance.frame = CGRectMake(240, 63, 180, 15);
        distance.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		distance.backgroundColor = [UIColor clearColor];
		distance.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:distance];
        
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    name.text = restaurant.name;
    tags.text = @"fun, awesome, totally cool";
    addressLine1.text = restaurant.address_1;
    addressLine2.text = @"Portland, OR 97209"; //[NSString stringWithFormat:@"%@",restaurant.address_2];
    distance.text = @"0.2 mi";

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc
{
    [imageView release]; 
    [name release]; 
    [tags release];
    [addressLine1 release];
    [addressLine2 release]; 
    [distance release];
    [super dealloc];
}

@end
