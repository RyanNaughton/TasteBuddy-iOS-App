//
//  DealsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/31/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DealsCell.h"
#import <QuartzCore/QuartzCore.h>
#import "iRestaurantAppDelegate.h"

@implementation DealsCell
@synthesize dealImageView, dealLabel, distanceLabel, durationLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        dealImageView = [[UIImageView alloc]init];
        dealImageView.contentMode = UIViewContentModeScaleAspectFill;
        dealImageView.clipsToBounds = YES;
        dealImageView.frame = CGRectMake(2, 2, 65, 65);
        dealImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        dealImageView.layer.borderWidth = 1;
        [self.contentView addSubview:dealImageView];
        
        dealLabel = [[UILabel alloc]init];
        dealLabel.frame = CGRectMake(75, 5, 200, 45);
        dealLabel.numberOfLines = 3;
        dealLabel.adjustsFontSizeToFitWidth = TRUE;
        dealLabel.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		dealLabel.backgroundColor = [UIColor clearColor];
		dealLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:dealLabel];
        
        distanceLabel = [[UILabel alloc]init];
        distanceLabel.frame = CGRectMake(270, 5, 75, 20);
        distanceLabel.adjustsFontSizeToFitWidth = FALSE;
        distanceLabel.textColor = [UIColor darkGrayColor];
		distanceLabel.backgroundColor = [UIColor clearColor];
		distanceLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:distanceLabel];
        
        durationLabel = [[UILabel alloc]init];
        durationLabel.frame = CGRectMake(75, 50, 155, 20);
        durationLabel.adjustsFontSizeToFitWidth = FALSE;
        durationLabel.textColor = [UIColor darkGrayColor];
		durationLabel.backgroundColor = [UIColor clearColor];
		durationLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:durationLabel];

    }
    return self;
}

-(void) setDistanceLabelWithDictionary:(NSDictionary *)dict {
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSArray *locArray = [[dict objectForKey:@"business"] objectForKey:@"locations"];    
    double latitude;
    double longitude;
    
    if ([locArray count] > 0) {
        NSString *latString = [[locArray objectAtIndex:0] objectForKey:@"lat"];
        NSString *longString = [[locArray objectAtIndex:0] objectForKey:@"lon"];
        latitude = [latString doubleValue];
        longitude = [longString doubleValue];
    } else {
        latitude = 0;
        longitude = 0;
    }
    
    CLLocation *dealLocation = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLLocationDistance distance = [appDelegate.currentLocation distanceFromLocation:dealLocation];    
    float milesFromLoc = distance / 1609.344;
    distanceLabel.text = [NSString stringWithFormat:@"%.02fmi", milesFromLoc];
}

-(void)setDurationLabelWithDictionary:(NSDictionary *)dict 
{    
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
	[inputDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [inputDateFormatter dateFromString:[dict objectForKey:@"end_date"]];
    NSDate *today = [NSDate date];
    NSTimeInterval timeRemaining = [today timeIntervalSinceDate:endDate];
    int days = floor(((timeRemaining / 60) / 60) / 24);
    days = abs(days);
    NSString *trailingS;
    if (days > 1) { trailingS = @"s"; } else { trailingS = @""; }
    durationLabel.text = [NSString stringWithFormat:@"%i day%@ remaining", days, trailingS];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [durationLabel release];
    [distanceLabel release];
    [dealImageView release];
    [dealLabel release];
    [super dealloc];
}

@end
