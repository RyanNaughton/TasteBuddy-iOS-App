//
//  ProfilePhotoDayTopCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProfilePhotoDayTopCell : UITableViewCell {
    UILabel *dayLabel;
}

@property (nonatomic, retain) UILabel *dayLabel;

-(void)setDate:(NSString *)date;

@end
