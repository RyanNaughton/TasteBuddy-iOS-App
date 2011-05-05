//
//  ProfileHeadCell.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProfileHeadCell : UITableViewCell {
    UILabel *nameLabel;
    UILabel *reviewsLabel;
    UILabel *picturesLabel;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *reviewsLabel;
@property (nonatomic, retain) UILabel *picturesLabel;

-(void)setUserInfo;

@end
