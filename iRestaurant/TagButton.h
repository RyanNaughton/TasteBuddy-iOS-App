//
//  TagButton.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tag.h"
#import "RestaurantTaggingService.h"
#import "Restaurant.h"

@interface TagButton : UIButton<RestaurantTaggingServiceDelegate> {
    Tag *tag;
    UILabel *tagName;
    UIImageView *circleImageView;
    UIImage *circlePlus;
    UIImage *circleCheck;
    UIImage *greyButtonImage;
    RestaurantTaggingService *restauarantTaggingService;
    Restaurant *restaurant;
}

@property (nonatomic, retain) Tag *tag;
@property (nonatomic, retain) UILabel *tagName;
@property (nonatomic, retain) UIImageView *circleImageView;
@property (nonatomic, retain) UIImage *circlePlus;
@property (nonatomic, retain) UIImage *circleCheck;
@property (nonatomic, retain) UIImage *greyButtonImage;
@property (nonatomic, retain) RestaurantTaggingService *restauarantTaggingService;
@property (nonatomic, retain) Restaurant *restaurant;

-(void) loadTag:(Tag *) tagToLoad andRestaurant:(Restaurant *) restaurant;
-(void) refreshTag;
@end
