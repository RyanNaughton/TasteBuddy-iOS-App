//
//  DishesSearchCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishCell.h"
#import "MenuItem.h"
#import "UIImageView+WebCache.h"
#import "RatingView.h"

@implementation DishCell
@synthesize imageView, name, tags, price, ratingView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(5, 5, 55, 55);
        [self.contentView addSubview:imageView];
        
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(65, 7, 180, 20);
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:name];
        
        tags = [[UILabel alloc]init];
        tags.frame = CGRectMake(65, 25, 180, 15);
        tags.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		tags.backgroundColor = [UIColor clearColor];
		UIFont *italicFont = [UIFont fontWithName:@"Helvetica-Oblique" size:12];
        tags.font = italicFont;
        [self.contentView addSubview:tags];
        
        price = [[UILabel alloc]init];
        price.frame = CGRectMake(245, 30, 180, 15);
        price.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		price.backgroundColor = [UIColor clearColor];
        price.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:price];
        
        ratingView = [[RatingView alloc]initWithRating:50 andStarSize:20 andIsUserRating:FALSE andIsEditable:FALSE];
        ratingView.frame = CGRectMake(65, 40, 100, 20);
        [self.contentView addSubview:ratingView];
        
    }
    return self;
}

-(void)loadMenuItem:(MenuItem *)menuItem {
    name.text = menuItem.name;
    tags.text = @"fun, awesome, totally cool";
    price.text = @"$7.95";
    [imageView setImageWithURL:[NSURL URLWithString:[[menuItem.pictures objectAtIndex:0] objectForKey:@"80px"]]
              placeholderImage:[UIImage imageNamed:@"restaurant-icon.gif"]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [ratingView release];
    [imageView release];
    [name release];
    [tags release];
    [price release];
    [super dealloc];
}

@end
