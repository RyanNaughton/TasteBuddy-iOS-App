//
//  DishHeaderCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishHeaderCell.h"
#import "MenuItem.h"

@implementation DishHeaderCell

@synthesize imageView, price;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(75, 25, 150, 150);
        //imageView.center = CGPointMake(self.contentView.center.x, 80);
        [self.contentView addSubview:imageView];
        
        price = [[UILabel alloc]init];
        price.frame = CGRectMake(75, 5, 150, 20);
        price.textAlignment = UITextAlignmentCenter;
        price.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		price.backgroundColor = [UIColor clearColor];
		price.font = [UIFont boldSystemFontOfSize:14];
        price.shadowColor = [UIColor whiteColor];
        price.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:price];
        
    }
    return self;
}

-(void)loadMenuItem:(MenuItem *)menu_item 
{
    price.text = @"$9.99";
    imageView.image = [UIImage imageNamed:@"restaurant-icon.gif"];
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
