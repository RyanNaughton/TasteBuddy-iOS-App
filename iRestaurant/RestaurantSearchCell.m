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
#import "StringSizeUtility.h"

@implementation RestaurantSearchCell
@synthesize name, tags, addressLine1, distance, ratingView, averageDishPrice, cuisine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code  
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.backgroundColor = [UIColor clearColor];
        
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(10, 13, 210, 20);
        name.adjustsFontSizeToFitWidth = FALSE;
        name.textColor = [UIColor blackColor];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:name];
        
        cuisine = [[UILabel alloc]init];
        cuisine.frame = CGRectMake(10, 0, 100, 20);
        cuisine.adjustsFontSizeToFitWidth = FALSE;
        cuisine.textColor = [UIColor grayColor];
		cuisine.backgroundColor = [UIColor clearColor];
		cuisine.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:cuisine];

        addressLine1 = [[UILabel alloc]init];
        addressLine1.frame = CGRectMake(10, 32, 180, 15);
        addressLine1.textColor = [UIColor blackColor];
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
        ratingView = [[RatingView alloc] initWithStarSize:starSize andLabelVisible:NO];
        ratingView.contentMode = UIViewContentModeScaleAspectFit;
        ratingView.clipsToBounds = TRUE;
        ratingView.frame = CGRectMake((310 - (starSize * 5)), 10, (starSize * 5), 20);
        [self.contentView addSubview:ratingView];
        
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    name.text = [restaurant.name retain];
    tags.text = [restaurant tagsText];
    addressLine1.text = [restaurant.address_1 retain];
    
    CGFloat xForCuisine = [StringSizeUtility widthOfString:name.text withFrame:name.frame andFont:name.font];
    cuisine.text = [restaurant.cuisine_types objectAtIndex:0];
  //  CGRect oldFrame = cuisine.frame;
 //   cuisine.frame = CGRectMake(xForCuisine + 15, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height);
    if(restaurant.distance == nil) {
        distance.hidden = YES;
    } else {
        distance.hidden = NO;
        distance.text = [NSString stringWithFormat:@"%@ miles", [restaurant.distance retain]];
    }
    averageDishPrice.text = [NSString stringWithFormat:@"avg. dish: $%.2f", restaurant.average_meal_price];
    
    if ([averageDishPrice.text isEqualToString:@"avg. dish: $0.00"]) {
        averageDishPrice.text = @"";
    }
    
    // set average rating
    [ratingView loadRating:restaurant.rating];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc
{
    [name release]; 
    [addressLine1 release];
    [tags release];
    [distance release];
    [averageDishPrice release];
    [ratingView release];
    [cuisine release];
    [super dealloc];
}

@end
