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
#import <QuartzCore/QuartzCore.h>

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
        imageView.frame = CGRectMake(2, 2, 65, 65);
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.borderWidth = 1;
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
        price.frame = CGRectMake(210, 35, 100, 35);
        price.textAlignment = UITextAlignmentRight;
        price.textColor = [UIColor darkGrayColor];
		price.backgroundColor = [UIColor clearColor];
        price.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:price];
        [price release];
        
        int starSize = 15;
        ratingView = [[RatingView alloc] initWithStarSize:starSize andLabelVisible:YES];
        ratingView.frame = CGRectMake((310 - (starSize * 5)), 10, (starSize * 5), 20);
        ratingView.ratingsLabel.frame = CGRectMake(0, 10, 75, 30);
        ratingView.ratingsLabel.textAlignment = UITextAlignmentRight;
        ratingView.ratingsLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:ratingView];
        [ratingView release];

        
    }
    return self;
}

-(void)loadMenuItem:(MenuItem *)menuItem {
    NSLog(@"menuItem pictures: %@", menuItem.pictures);
    UIImage *noImage = [UIImage imageNamed:@"no-image-80.png"];
    name.text = [menuItem.name retain];
    tags.text = [menuItem.tags_text retain];
    price.text = [NSString stringWithFormat:@"$%.2f", menuItem.price];
    
    if ([menuItem.pictures count] > 0) {
        [imageView setImageWithURL:[NSURL URLWithString:[[menuItem.pictures objectAtIndex:0] objectForKey:@"80px"]]
              placeholderImage:noImage];
    } else {
        imageView.image = noImage;
    }
    
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
