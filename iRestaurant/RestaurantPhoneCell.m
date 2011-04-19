//
//  RestaurantPhoneCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/14/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantPhoneCell.h"
#import "Restaurant.h"

@implementation RestaurantPhoneCell
@synthesize phone;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;

        phone = [[UILabel alloc]init];
        phone.frame = CGRectMake(25, 0, 250, 40);
        phone.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
        phone.textAlignment = UITextAlignmentCenter;
		phone.backgroundColor = [UIColor clearColor];
		phone.font = [UIFont boldSystemFontOfSize:20];
        
        phone.shadowColor = [UIColor whiteColor];
        phone.shadowOffset = CGSizeMake(0,1);
        
        [self.contentView addSubview:phone];

    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant 
{
    phone.text = [NSString stringWithFormat:@"%@", restaurant.phone];
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
