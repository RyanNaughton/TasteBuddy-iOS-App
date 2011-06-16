//
//  FestivalCell.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 16/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Festival;

@interface FestivalCell : UITableViewCell {
    UILabel *festivalLabel;
    UILabel *datesLabel;
    UILabel *distanceLabel;
}

@property (nonatomic, retain) UILabel *festivalLabel;
@property (nonatomic, retain) UILabel *datesLabel;
@property (nonatomic, retain) UILabel *distanceLabel;

-(void) loadFestival:(Festival *)festival;

@end
