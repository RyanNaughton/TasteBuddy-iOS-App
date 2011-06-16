//
//  FestivalCell.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 16/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "FestivalCell.h"
#import "Festival.h"

@implementation FestivalCell

@synthesize festivalLabel;
@synthesize datesLabel;
@synthesize distanceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        datesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 175, 20)];
        datesLabel.font = [UIFont systemFontOfSize:12];
        datesLabel.textColor = [UIColor darkGrayColor];
        datesLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:datesLabel];

        festivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 30)];
        festivalLabel.font = [UIFont systemFontOfSize:20];
        festivalLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:festivalLabel];
        
        distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 30, 65, 35)];
        distanceLabel.font = [UIFont systemFontOfSize:12];
        distanceLabel.textAlignment = UITextAlignmentRight;
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:distanceLabel];
    }
    return self;
}

-(void) loadFestival:(Festival *)festival {
    festivalLabel.text = festival.name;
    distanceLabel.text = [NSString stringWithFormat:@"%.1f miles", festival.distance];
    datesLabel.text = [festival dates];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc {
    [festivalLabel release];
    [datesLabel release];
    [distanceLabel release];
    [super dealloc];
}

@end
