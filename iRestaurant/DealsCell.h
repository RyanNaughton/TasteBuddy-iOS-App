//
//  DealsCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/31/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DealsCell : UITableViewCell {
    UIImageView *dealImageView;
    UILabel *dealLabel;
    UILabel *distanceLabel;
    UILabel *durationLabel;
}

@property (nonatomic, retain) UIImageView *dealImageView;
@property (nonatomic, retain) UILabel *dealLabel;
@property (nonatomic, retain) UILabel *distanceLabel;
@property (nonatomic, retain) UILabel *durationLabel;

-(void) setDistanceLabelWithDictionary:(NSDictionary *)dict;
-(void)setDurationLabelWithDictionary:(NSDictionary *)dict;

@end
