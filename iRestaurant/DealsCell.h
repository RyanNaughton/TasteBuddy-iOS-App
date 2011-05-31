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
}

@property (nonatomic, retain) UIImageView *dealImageView;
@property (nonatomic, retain) UILabel *dealLabel;

@end
