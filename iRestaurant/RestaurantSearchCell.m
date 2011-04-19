//
//  RestaurantSearchCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantSearchCell.h"
#import "Restaurant.h"
#import "UIImageView+WebCache.h"
#import "RatingView.h"

@implementation RestaurantSearchCell
@synthesize name, tags, addressLine1, distance, ratingView, averageDishPrice;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code  
        //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(10, 7, 195, 20);
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:name];
                
        addressLine1 = [[UILabel alloc]init];
        addressLine1.frame = CGRectMake(10, 30, 180, 15);
        addressLine1.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		addressLine1.backgroundColor = [UIColor clearColor];
		addressLine1.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:addressLine1];
        
        tags = [[UILabel alloc]init];
        tags.frame = CGRectMake(10, 45, 180, 15);
        tags.textColor = [UIColor darkGrayColor];
		tags.backgroundColor = [UIColor clearColor];
		UIFont *italicFont = [UIFont fontWithName:@"Helvetica-Oblique" size:12];
        tags.font = italicFont;
        [self.contentView addSubview:tags];
        
        distance = [[UILabel alloc]init];
        distance.frame = CGRectMake(240, 30, 70, 15);
        distance.textAlignment = UITextAlignmentRight;
        distance.textColor = [UIColor darkGrayColor];
		distance.backgroundColor = [UIColor clearColor];
		distance.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:distance];

        averageDishPrice = [[UILabel alloc]init];
        averageDishPrice.frame = CGRectMake(200, 45, 110, 15);
        averageDishPrice.textAlignment = UITextAlignmentRight;
        averageDishPrice.textColor = [UIColor darkGrayColor];
		averageDishPrice.backgroundColor = [UIColor clearColor];
		averageDishPrice.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:averageDishPrice];
        
        int starSize = 15;
        ratingView = [[RatingView alloc]initWithRating:50 andStarSize:starSize andIsUserRating:FALSE andIsEditable:FALSE];
        ratingView.contentMode = UIViewContentModeScaleAspectFit;
        ratingView.clipsToBounds = TRUE;
        ratingView.frame = CGRectMake((310 - (starSize * 5)), 10, (starSize * 5), 20);
        [self.contentView addSubview:ratingView];
        
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    name.text = restaurant.name;
    tags.text = @"fun, awesome, totally cool";
    addressLine1.text = restaurant.address_1;
    distance.text = [NSString stringWithFormat:@"%@ miles", restaurant.distance];
    averageDishPrice.text = [NSString stringWithFormat:@"avg. dish: $%@", restaurant.average_meal_price];
    
    // set average rating
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc
{
    [name release]; 
    [tags release];
    [addressLine1 release];
    [distance release];
    [averageDishPrice release];
    [ratingView release];
    [super dealloc];
}

@end
