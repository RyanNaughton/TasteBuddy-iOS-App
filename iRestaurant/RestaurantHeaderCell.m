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
@synthesize imageView, name, lunch_hours, dinner_hours, average_meal, cuisine_types, ratingView, favoriteButton, greyHeart, redHeart;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        greyHeart = [UIImage imageNamed:@"29-heart.png"];
        redHeart = [UIImage imageNamed:@"red-heart.png"];
        
        imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(10, 55, 120, 120);
        [self.contentView addSubview:imageView];
        
        favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [favoriteButton addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [favoriteButton setBackgroundImage:greyHeart forState:UIControlStateNormal];
        favoriteButton.frame = CGRectMake(280, 10, 20, 20);
        [self.contentView addSubview:favoriteButton];
        
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(10, 7, 280, 20);
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:18];
        name.shadowColor = [UIColor whiteColor];
        name.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:name];
        
        ratingView = [[RatingView alloc]initWithRating:50 andHowManyRatings:267 andStarSize:20 andIsUserRating:FALSE andIsEditable:TRUE];
        ratingView.frame = CGRectMake(10, 30, 100, 20);
        [self.contentView addSubview:ratingView];
        
        UIView *greyLine = [[UIView alloc]initWithFrame:CGRectMake(140, 85, 170, 1)];
        greyLine.backgroundColor = [UIColor lightGrayColor];
        greyLine.alpha = 0.5;
        [self.contentView addSubview:greyLine];
        [greyLine release];
        
        UIView *greyLine2 = [[UIView alloc]initWithFrame:CGRectMake(140, 115, 170, 1)];
        greyLine2.backgroundColor = [UIColor lightGrayColor];
        greyLine2.alpha = 0.5;
        [self.contentView addSubview:greyLine2];
        [greyLine2 release];
        
        UIView *greyLine3 = [[UIView alloc]initWithFrame:CGRectMake(140, 145, 170, 1)];
        greyLine3.backgroundColor = [UIColor lightGrayColor];
        greyLine3.alpha = 0.5;
        [self.contentView addSubview:greyLine3];
        [greyLine3 release];
        
        UILabel *lunch_text = [[UILabel alloc]init];
        lunch_text.frame = CGRectMake(155, 60, 155, 20);
        lunch_text.textColor = [UIColor darkGrayColor];
		lunch_text.backgroundColor = [UIColor clearColor];
        lunch_text.textAlignment = UITextAlignmentRight;
		lunch_text.font = [UIFont systemFontOfSize:12];
        lunch_text.shadowColor = [UIColor whiteColor];
        lunch_text.shadowOffset = CGSizeMake(0,1);
        lunch_text.text = @"lunch";
        [self.contentView addSubview:lunch_text];
        [lunch_text release];
        
        UILabel *dinner_text = [[UILabel alloc]init];
        dinner_text.frame = CGRectMake(155, 90, 155, 20);
        dinner_text.textColor = [UIColor darkGrayColor];
		dinner_text.backgroundColor = [UIColor clearColor];
        dinner_text.textAlignment = UITextAlignmentRight;
		dinner_text.font = [UIFont systemFontOfSize:12];
        dinner_text.shadowColor = [UIColor whiteColor];
        dinner_text.shadowOffset = CGSizeMake(0,1);
        dinner_text.text = @"dinner";
        [self.contentView addSubview:dinner_text];
        [dinner_text release];

        
        UILabel *cuisine_types_text = [[UILabel alloc]init];
        cuisine_types_text.frame = CGRectMake(155, 120, 155, 20);
        cuisine_types_text.textColor = [UIColor darkGrayColor];
		cuisine_types_text.backgroundColor = [UIColor clearColor];
        cuisine_types_text.textAlignment = UITextAlignmentRight;
		cuisine_types_text.font = [UIFont systemFontOfSize:12];
        cuisine_types_text.shadowColor = [UIColor whiteColor];
        cuisine_types_text.shadowOffset = CGSizeMake(0,1);
        cuisine_types_text.text = @"cuisine";
        [self.contentView addSubview:cuisine_types_text];
        [cuisine_types_text release];
        
        cuisine_types = [[UILabel alloc]init];
        cuisine_types.frame = CGRectMake(140, 120, 155, 20);
        cuisine_types.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		cuisine_types.backgroundColor = [UIColor clearColor];
		cuisine_types.font = [UIFont systemFontOfSize:13];
        cuisine_types.shadowColor = [UIColor whiteColor];
        cuisine_types.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:cuisine_types];
        
        lunch_hours = [[UILabel alloc]init];
        lunch_hours.frame = CGRectMake(140, 60, 160, 20);
        lunch_hours.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		lunch_hours.backgroundColor = [UIColor clearColor];
		lunch_hours.font = [UIFont systemFontOfSize:13];
        lunch_hours.shadowColor = [UIColor whiteColor];
        lunch_hours.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:lunch_hours];
        
        dinner_hours = [[UILabel alloc]init];
        dinner_hours.frame = CGRectMake(140, 90, 160, 20);
        dinner_hours.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		dinner_hours.backgroundColor = [UIColor clearColor];
		dinner_hours.font = [UIFont systemFontOfSize:13];
        dinner_hours.shadowColor = [UIColor whiteColor];
        dinner_hours.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:dinner_hours];

        
        UILabel *average_meal_text = [[UILabel alloc]init];
        average_meal_text.frame = CGRectMake(155, 150, 155, 20);
        average_meal_text.textColor = [UIColor darkGrayColor];
		average_meal_text.backgroundColor = [UIColor clearColor];
        average_meal_text.textAlignment = UITextAlignmentRight;
		average_meal_text.font = [UIFont systemFontOfSize:12];
        average_meal_text.shadowColor = [UIColor whiteColor];
        average_meal_text.shadowOffset = CGSizeMake(0,1);
        average_meal_text.text = @"avg. dish price";
        [self.contentView addSubview:average_meal_text];
        [average_meal_text release];

        
        average_meal = [[UILabel alloc]init];
        average_meal.frame = CGRectMake(140, 150, 155, 20);
        average_meal.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		average_meal.backgroundColor = [UIColor clearColor];
		average_meal.font = [UIFont systemFontOfSize:14];
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
    lunch_hours.text = @"11:00am - 1:00pm";
    dinner_hours.text = @"3:00am - 1:00am";
        
    NSString* average_meal_price_formatted = [NSString stringWithFormat:@"%.02f", [restaurant.average_meal_price floatValue]];
    
    average_meal.text = [NSString stringWithFormat:@"$%@", average_meal_price_formatted];
    
    if ([restaurant.cuisine_types count] > 1) {
        for (int i=0; i < [restaurant.cuisine_types count]; i++) {
            NSString *spacer;
            if (i==0) { spacer = @"Cuisine: "; } else { spacer = @", "; }
            cuisine_types.text = [NSString stringWithFormat:@"%@%@%@", cuisine_types.text, spacer, [restaurant.cuisine_types objectAtIndex:i]];
        }
    } else  {
        cuisine_types.text = [NSString stringWithFormat:@"%@", [restaurant.cuisine_types objectAtIndex:0]];
    }
}

-(void) favoriteButtonPressed:(id)sender {
    NSLog(@"fav button pressed");
    //UIButton *favoriteButton = (UIButton *)sender;
    [favoriteButton setBackgroundImage:redHeart forState:UIControlStateNormal];
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
    [lunch_hours release];
    [dinner_hours release];
    [average_meal release];
    [cuisine_types release];
    [super dealloc];
}

@end
