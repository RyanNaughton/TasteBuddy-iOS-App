//
//  DishesSearchCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishCell.h"
#import "MenuItem.h"

@implementation DishCell
@synthesize imageView, name, tags, price;

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
        imageView.frame = CGRectMake(5, 5, 50, 50);
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
    }
    return self;
}

-(void)loadMenuItem:(MenuItem *)menuItem {
    name.text = menuItem.name;
    tags.text = @"fun, awesome, totally cool";
    price.text = @"$7.95";
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
    [price release];
    [super dealloc];
}

@end
