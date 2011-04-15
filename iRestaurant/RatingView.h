//
//  RatingView.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RatingView : UIView {
    UIView *allOutlineStarsView;
}

@property (nonatomic, retain) UIView *allOutlineStarsView;

-(void) setupAllOutlineStarsView;

@end
