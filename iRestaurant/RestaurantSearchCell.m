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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andRestaurant:(Restaurant *)restaurant 
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code  
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        NSURL *aURL = [NSURL URLWithString:@"http://www.bokachicago.com/images/tour/1.jpg"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:aURL];
        imageView.image = [UIImage imageWithData:data];
        [data release];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(7, 7, 80, 80);
        [self.contentView addSubview:imageView];
        [imageView release];
        
        UILabel *name = [[UILabel alloc]init];
		name.text = restaurant.name;
        name.frame = CGRectMake(100, 7, 180, 15);
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:name];
        [name release];
                
        UILabel *tags = [[UILabel alloc]init];
		tags.text = @"fun, awesome, totally cool";
        tags.frame = CGRectMake(100, 25, 180, 15);
        tags.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		tags.backgroundColor = [UIColor clearColor];
		UIFont *italicFont = [UIFont fontWithName:@"Helvetica-Oblique" size:12];
        tags.font = italicFont;
        [self.contentView addSubview:tags];
        [tags release];
        
        UILabel *addressLine1 = [[UILabel alloc]init];
		addressLine1.text = restaurant.address_1;
        addressLine1.frame = CGRectMake(100, 55, 180, 15);
        addressLine1.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		addressLine1.backgroundColor = [UIColor clearColor];
		addressLine1.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:addressLine1];
        [addressLine1 release];
        
        UILabel *addressLine2 = [[UILabel alloc]init];
		addressLine2.text = @"Portland, OR 97209"; //[NSString stringWithFormat:@"%@",restaurant.address_2];
        addressLine2.frame = CGRectMake(100, 70, 180, 15);
        addressLine2.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		addressLine2.backgroundColor = [UIColor clearColor];
		addressLine2.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:addressLine2];
        [addressLine2 release];

        UILabel *distance = [[UILabel alloc]init];
		distance.text = @"0.2 mi";
        distance.frame = CGRectMake(240, 63, 180, 15);
        distance.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		distance.backgroundColor = [UIColor clearColor];
		distance.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:distance];
        [distance release];
        
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
    [super dealloc];
}

@end
