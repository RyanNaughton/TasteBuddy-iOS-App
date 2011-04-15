//
//  DishesSearchCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItem;

@interface DishCell : UITableViewCell {
    
    UIImageView *imageView;
    UILabel *name        ;
    UILabel *tags        ;
    UILabel *price;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *name        ;
@property (nonatomic, retain) UILabel *tags        ;
@property (nonatomic, retain) UILabel *price;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)loadMenuItem:(MenuItem *)menuItem;
@end
