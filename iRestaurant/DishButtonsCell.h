//
//  DishButtonsCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/18/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DishViewController;

@interface DishButtonsCell : UITableViewCell {
    DishViewController *dishViewController;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andParentView:(DishViewController *)dishViewController_passed;

@property (nonatomic, retain) DishViewController *dishViewController;

@end
