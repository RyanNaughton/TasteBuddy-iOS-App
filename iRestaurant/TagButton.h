//
//  TagButton.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
@class Tag;

@interface TagButton : UIButton {
    UILabel *tagName;
    UIImageView *circleImageView;
}

@property (nonatomic, retain) UILabel *tagName;
@property (nonatomic, retain) UIImageView *circleImageView;

-(void) prepareButton;
-(void) loadTag:(Tag *) tagToLoad;

@end
