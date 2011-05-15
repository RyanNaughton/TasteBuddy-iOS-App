//
//  RestaurantAdditionalInformationCell.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantAdditionalInformationCell.h"
#import "Restaurant.h"

@implementation RestaurantAdditionalInformationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *topRounding = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top-rounding.png"]];
        topRounding.frame = CGRectMake(0, 10, 320, 15);
        [self.contentView addSubview:topRounding];
        [topRounding release];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(10, 25, 320, 15);
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.shadowColor = [UIColor whiteColor];
        titleLabel.shadowOffset = CGSizeMake(0,1);
        titleLabel.text = @"Additional Information";
        [self.contentView addSubview:titleLabel];
        [titleLabel release];
        
        self.selectionStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurantPassed {
    
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
