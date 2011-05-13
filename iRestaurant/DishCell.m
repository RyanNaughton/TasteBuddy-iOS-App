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
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(0, 0, 70, 70);
        [self.contentView addSubview:imageView];
        [imageView release];
        
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(80, 5, 160, 20);
        name.adjustsFontSizeToFitWidth = FALSE;
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:name];
        [name release];
        
        tags = [[UILabel alloc]init];
        tags.frame = CGRectMake(80, 25, 180, 15);
        tags.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		tags.backgroundColor = [UIColor clearColor];
		UIFont *italicFont = [UIFont fontWithName:@"Helvetica-Oblique" size:12];
        tags.font = italicFont;
        [self.contentView addSubview:tags];
        [tags release];
        
        price = [[UILabel alloc]init];
        price.frame = CGRectMake(245, 30, 180, 15);
        price.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		price.backgroundColor = [UIColor clearColor];
        price.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:price];
        [price release];
        
        int starSize = 12;
        ratingView = [[RatingView alloc] initWithStarSize:12 andLabelVisible:NO];
        ratingView.frame = CGRectMake((310 - (starSize * 5)), 5, (starSize * 5), starSize);
        [self.contentView addSubview:ratingView];
        [ratingView release];

        
    }
    return self;
}

-(void)loadMenuItem:(MenuItem *)menuItem {
    name.text = menuItem.name;
    tags.text = menuItem.tags_text;
    price.text = [NSString stringWithFormat:@"$%.2f", menuItem.price];
    [imageView setImageWithURL:[NSURL URLWithString:[[menuItem.pictures objectAtIndex:0] objectForKey:@"80px"]]
              placeholderImage:[UIImage imageNamed:@"restaurant-icon.gif"]];
    
    [ratingView loadRating:menuItem.rating];

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
