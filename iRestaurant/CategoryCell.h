//
//  CategoryCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/9/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CategoryCell : UITableViewCell {
    UILabel *name;
    UILabel *count;
}

@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *count;


@end
