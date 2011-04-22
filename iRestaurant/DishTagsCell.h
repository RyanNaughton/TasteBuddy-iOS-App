//
//  DishTagsCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/21/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItem;

@interface DishTagsCell : UITableViewCell {
    UIImage *circlePlus;
    UIImage *circleCheck;

}

@property (nonatomic, retain) UIImage *circlePlus;
@property (nonatomic, retain) UIImage *circleCheck;

-(void) loadMenuItem:(MenuItem *)menu_item;
-(void)tagButtonPressed:(id)sender;

@end
