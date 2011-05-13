//
//  ProfilePhotoCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProfilePhotoCell : UITableViewCell {
    UIImageView *imageView;
    UILabel *restaurantLabel;
    UILabel *pictureCountLabel;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *restaurantLabel;
@property (nonatomic, retain) UILabel *pictureCountLabel;

-(void) setLabels;

-(void)setVariablesWithDictionary:(NSDictionary *)restaurantDictionary;

@end
