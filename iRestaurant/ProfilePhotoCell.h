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
    NSDictionary *restaurantDictionary;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *restaurantLabel;
@property (nonatomic, retain) UILabel *pictureCountLabel;
@property (nonatomic, retain) NSDictionary *restaurantDictionary;

-(void)setVariablesWithDictionary:(NSDictionary *)restaurantDictionary_passed;
-(void)imageButtonPressed:(id)sender;
-(void)restaurantButtonPressed:(id)sender;

@end
