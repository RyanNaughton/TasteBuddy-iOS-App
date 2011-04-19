//
//  RestaurantHeaderCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantHeaderCell.h"
#import "Restaurant.h"
#import "UIImageView+WebCache.h"
#import "RatingView.h"

@implementation RestaurantHeaderCell
@synthesize imageView, name, hours, average_meal, cuisine_types, ratingView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        //UIView *selectedBGView = [[UIView alloc]initWithFrame:self.contentView.frame];
        //selectedBGView.backgroundColor = [UIColor redColor];
        //self.selectedBackgroundView = selectedBGView;
        self.backgroundColor = [UIColor whiteColor];
        
//        UIView *background = [[UIView alloc]init];
//        background.backgroundColor = [UIColor blackColor];
//        background.alpha = 0.25;
//        self.backgroundView = background;
//        [background release];
        
        imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(10, 55, 120, 120);
        [self.contentView addSubview:imageView];
        
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(10, 7, 280, 20);
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:18];
        name.shadowColor = [UIColor whiteColor];
        name.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:name];
        
        ratingView = [[RatingView alloc]initWithRating:50 andIsUserRating:FALSE andIsEditable:TRUE];
        ratingView.frame = CGRectMake(10, 30, 100, 20);
        [self.contentView addSubview:ratingView];
        
        cuisine_types = [[UILabel alloc]init];
        cuisine_types.frame = CGRectMake(140, 60, 160, 20);
        cuisine_types.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		cuisine_types.backgroundColor = [UIColor clearColor];
		cuisine_types.font = [UIFont systemFontOfSize:13];
        cuisine_types.shadowColor = [UIColor whiteColor];
        cuisine_types.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:cuisine_types];
        
        hours = [[UILabel alloc]init];
        hours.frame = CGRectMake(140, 80, 160, 20);
        hours.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		hours.backgroundColor = [UIColor clearColor];
		hours.font = [UIFont systemFontOfSize:13];
        hours.shadowColor = [UIColor whiteColor];
        hours.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:hours];
        
        average_meal = [[UILabel alloc]init];
        average_meal.frame = CGRectMake(140, 100, 160, 20);
        average_meal.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		average_meal.backgroundColor = [UIColor clearColor];
		average_meal.font = [UIFont systemFontOfSize:11];
        average_meal.shadowColor = [UIColor whiteColor];
        average_meal.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:average_meal];
    
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    if ([restaurant.pictures count] > 0) {
        [imageView setImageWithURL:[NSURL URLWithString:[[restaurant.pictures objectAtIndex:0] objectForKey:@"160px"]]
                  placeholderImage:[UIImage imageNamed:@"restaurant-icon.gif"]];
    } else {
        imageView.image = [UIImage imageNamed:@"restaurant-icon.gif"];
    }
    name.text = restaurant.name;
    hours.text = @"Hours unavailable"; //restaurant.hours;
    average_meal.text = [NSString stringWithFormat:@"Average meal: $%@", restaurant.average_meal_price];
    
    if ([restaurant.cuisine_types count] > 1) {
        for (int i=0; i < [restaurant.cuisine_types count]; i++) {
            NSString *spacer;
            if (i==0) { spacer = @"Cuisine: "; } else { spacer = @", "; }
            cuisine_types.text = [NSString stringWithFormat:@"%@%@%@", cuisine_types.text, spacer, [restaurant.cuisine_types objectAtIndex:i]];
        }
    } else  {
        cuisine_types.text = [NSString stringWithFormat:@"Cuisine: %@", [restaurant.cuisine_types objectAtIndex:0]];
    }
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
    [ratingView release];
    [hours release];
    [average_meal release];
    [cuisine_types release];
    [super dealloc];
}

@end
