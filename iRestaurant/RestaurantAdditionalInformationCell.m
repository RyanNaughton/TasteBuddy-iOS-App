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
@synthesize deliveryText;
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
        
        alcoholText = [[UILabel alloc]init];
        alcoholText.frame = CGRectMake(10, 55, 140, 20);
        alcoholText.textColor = [UIColor blackColor];
		alcoholText.backgroundColor = [UIColor clearColor];
		alcoholText.font = [UIFont boldSystemFontOfSize:20];
        alcoholText.textAlignment = UITextAlignmentRight;
        alcoholText.shadowColor = [UIColor whiteColor];
        alcoholText.shadowOffset = CGSizeMake(0,1);
        alcoholText.text = @"-";
        [self.contentView addSubview:alcoholText];
        
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
        
        ccText = [[UILabel alloc]init];
        ccText.frame = CGRectMake(10, 85, 140, 20);
        ccText.textColor = [UIColor blackColor];
        ccText.backgroundColor = [UIColor clearColor];
        ccText.font = [UIFont boldSystemFontOfSize:20];
        ccText.textAlignment = UITextAlignmentRight;
        ccText.shadowColor = [UIColor whiteColor];
        ccText.shadowOffset = CGSizeMake(0,1);
        ccText.text = @"-";
        [self.contentView addSubview:ccText];

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
                
        deliveryText = [[UILabel alloc]init];
        deliveryText.frame = CGRectMake(10, 115, 140, 20);
        deliveryText.textColor = [UIColor blackColor];
        deliveryText.backgroundColor = [UIColor clearColor];
        deliveryText.font = [UIFont boldSystemFontOfSize:20];
        deliveryText.textAlignment = UITextAlignmentRight;
        deliveryText.shadowColor = [UIColor whiteColor];
        deliveryText.shadowOffset = CGSizeMake(0,1);
        deliveryText.text = @"-";
        [self.contentView addSubview:deliveryText];

        UILabel *parkingLabel = [[UILabel alloc]init];
        parkingLabel.frame = CGRectMake(170, 55, 140, 20);
        parkingLabel.textColor = [UIColor darkGrayColor];
        parkingLabel.backgroundColor = [UIColor clearColor];
        parkingLabel.textAlignment = UITextAlignmentLeft;
        parkingLabel.font = [UIFont systemFontOfSize:12];
        parkingLabel.shadowColor = [UIColor whiteColor];
        parkingLabel.shadowOffset = CGSizeMake(0,1);
        parkingLabel.text = @"parking";
        [self.contentView addSubview:parkingLabel];
        [parkingLabel release];
        
        parkingText = [[UILabel alloc]init];
        parkingText.frame = CGRectMake(170, 55, 140, 20);
        parkingText.textColor = [UIColor blackColor];
        parkingText.backgroundColor = [UIColor clearColor];
        parkingText.font = [UIFont boldSystemFontOfSize:20];
        parkingText.textAlignment = UITextAlignmentRight;
        parkingText.shadowColor = [UIColor whiteColor];
        parkingText.shadowOffset = CGSizeMake(0,1);
        parkingText.text = @"-";
        [self.contentView addSubview:parkingText];
        
        UIView *greyLine3 = [[UIView alloc]initWithFrame:CGRectMake(170, 80, 140, 1)];
        greyLine3.backgroundColor = [UIColor lightGrayColor];
        greyLine3.alpha = 0.5;
        [self.contentView addSubview:greyLine3];
        [greyLine3 release];
        
        UILabel *reservationsLabel = [[UILabel alloc]init];
        reservationsLabel.frame = CGRectMake(170, 85, 140, 20);
        reservationsLabel.textColor = [UIColor darkGrayColor];
        reservationsLabel.backgroundColor = [UIColor clearColor];
        reservationsLabel.textAlignment = UITextAlignmentLeft;
        reservationsLabel.font = [UIFont systemFontOfSize:12];
        reservationsLabel.shadowColor = [UIColor whiteColor];
        reservationsLabel.shadowOffset = CGSizeMake(0,1);
        reservationsLabel.text = @"reservations";
        [self.contentView addSubview:reservationsLabel];
        [reservationsLabel release];
        
        reservationsText = [[UILabel alloc]init];
        reservationsText.frame = CGRectMake(170, 85, 140, 20);
        reservationsText.textColor = [UIColor blackColor];
        reservationsText.backgroundColor = [UIColor clearColor];
        reservationsText.font = [UIFont boldSystemFontOfSize:20];
        reservationsText.textAlignment = UITextAlignmentRight;
        reservationsText.shadowColor = [UIColor whiteColor];
        reservationsText.shadowOffset = CGSizeMake(0,1);
        reservationsText.text = @"-";
        [self.contentView addSubview:reservationsText];
        
        UIView *greyLine4 = [[UIView alloc]initWithFrame:CGRectMake(170, 110, 140, 1)];
        greyLine4.backgroundColor = [UIColor lightGrayColor];
        greyLine4.alpha = 0.5;
        [self.contentView addSubview:greyLine4];
        [greyLine4 release];
        
        
        UILabel *wifiLabel = [[UILabel alloc]init];
        wifiLabel.frame = CGRectMake(170, 115, 140, 20);
        wifiLabel.textColor = [UIColor darkGrayColor];
        wifiLabel.backgroundColor = [UIColor clearColor];
        wifiLabel.textAlignment = UITextAlignmentLeft;
        wifiLabel.font = [UIFont systemFontOfSize:12];
        wifiLabel.shadowColor = [UIColor whiteColor];
        wifiLabel.shadowOffset = CGSizeMake(0,1);
        wifiLabel.text = @"wifi";
        [self.contentView addSubview:wifiLabel];
        [wifiLabel release];
        
        wifiText = [[UILabel alloc]init];
        wifiText.frame = CGRectMake(170, 115, 140, 20);
        wifiText.textColor = [UIColor blackColor];
        wifiText.backgroundColor = [UIColor clearColor];
        wifiText.font = [UIFont boldSystemFontOfSize:20];
        wifiText.textAlignment = UITextAlignmentRight;
        wifiText.shadowColor = [UIColor whiteColor];
        wifiText.shadowOffset = CGSizeMake(0,1);
        wifiText.text = @"-";
        [self.contentView addSubview:wifiText];
        
        
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
    [alcoholText release];
    [deliveryText release];
    [ccText release];
    [parkingText release];
    [reservationsText release];
    [wifiText release];
    [super dealloc];
}

@end
