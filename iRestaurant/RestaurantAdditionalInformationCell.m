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

@synthesize alcoholText;
@synthesize deliveryLabel;
@synthesize ccText;
@synthesize parkingText;
@synthesize reservationsText;
@synthesize wifiText;

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
        
        
        UILabel *alcoholLabel = [[UILabel alloc]init];
        alcoholLabel.frame = CGRectMake(10, 55, 140, 20);
        alcoholLabel.textColor = [UIColor darkGrayColor];
		alcoholLabel.backgroundColor = [UIColor clearColor];
        alcoholLabel.textAlignment = UITextAlignmentLeft;
		alcoholLabel.font = [UIFont systemFontOfSize:12];
        alcoholLabel.shadowColor = [UIColor whiteColor];
        alcoholLabel.shadowOffset = CGSizeMake(0,1);
        alcoholLabel.text = @"alcohol";
        [self.contentView addSubview:alcoholLabel];
        [alcoholLabel release];
        
        
        UIView *greyLine = [[UIView alloc]initWithFrame:CGRectMake(10, 80, 140, 1)];
        greyLine.backgroundColor = [UIColor lightGrayColor];
        greyLine.alpha = 0.5;
        [self.contentView addSubview:greyLine];
        [greyLine release];
        
        UILabel *ccLabel = [[UILabel alloc]init];
        ccLabel.frame = CGRectMake(10, 85, 140, 20);
        ccLabel.textColor = [UIColor darkGrayColor];
		ccLabel.backgroundColor = [UIColor clearColor];
        ccLabel.textAlignment = UITextAlignmentLeft;
		ccLabel.font = [UIFont systemFontOfSize:12];
        ccLabel.shadowColor = [UIColor whiteColor];
        ccLabel.shadowOffset = CGSizeMake(0,1);
        ccLabel.text = @"credit cards";
        [self.contentView addSubview:ccLabel];
        [ccLabel release];
        
        UIView *greyLine2 = [[UIView alloc]initWithFrame:CGRectMake(10, 110, 140, 1)];
        greyLine2.backgroundColor = [UIColor lightGrayColor];
        greyLine2.alpha = 0.5;
        [self.contentView addSubview:greyLine2];
        [greyLine2 release];

        
        UILabel *deliveryLabel = [[UILabel alloc]init];
        deliveryLabel.frame = CGRectMake(10, 115, 140, 20);
        deliveryLabel.textColor = [UIColor darkGrayColor];
		deliveryLabel.backgroundColor = [UIColor clearColor];
        deliveryLabel.textAlignment = UITextAlignmentLeft;
		deliveryLabel.font = [UIFont systemFontOfSize:12];
        deliveryLabel.shadowColor = [UIColor whiteColor];
        deliveryLabel.shadowOffset = CGSizeMake(0,1);
        deliveryLabel.text = @"delivery";
        [self.contentView addSubview:deliveryLabel];
        [deliveryLabel release];
        
        
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
