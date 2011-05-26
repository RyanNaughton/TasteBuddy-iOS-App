//
//  ProfilePhotoCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantService.h"
@class Restaurant;
@class ProfileTableViewController;

@interface ProfilePhotoCell : UITableViewCell <RestaurantServiceDelegate> {
    UIImageView *imageView;
    UILabel *restaurantLabel;
    UILabel *pictureCountLabel;
    NSDictionary *restaurantDictionary;
    ProfileTableViewController *ptvc;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *restaurantLabel;
@property (nonatomic, retain) UILabel *pictureCountLabel;
@property (nonatomic, retain) NSDictionary *restaurantDictionary;
@property (nonatomic, retain) ProfileTableViewController *ptvc;

-(void)setVariablesWithDictionary:(NSDictionary *)restaurantDictionary_passed;
-(void)imageButtonPressed:(id)sender;
-(void)restaurantButtonPressed:(id)sender;
-(void)restaurantRetrieved:(Restaurant *) restuarant;

@end
