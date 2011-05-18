//
//  TagButton.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TagButton.h"
#import "Tag.h"

@implementation TagButton

@synthesize tagName, circleImageView;

-(void) prepareButton {
        
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    tagName = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 110, 15)];
    tagName.backgroundColor = [UIColor clearColor];
    tagName.font = [UIFont systemFontOfSize:13];
    [self addSubview:tagName];
    
    
    circleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"33-circle-plus.png"]];
    circleImageView.frame = CGRectMake(120, 7, 15, 15);
    circleImageView.alpha = 0.7;
    [self addSubview:circleImageView];
}

-(void) loadTag:(Tag *) tag {
    
    tagName.text = [NSString stringWithFormat:@"%@ (%i)", [tag.name retain], tag.count];    
    
    if (tag.isUserTag) {
        UIImage *greyButtonImage = [[UIImage imageNamed:@"grey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        [self setBackgroundImage:greyButtonImage forState:UIControlStateNormal];

        circleImageView.image = [UIImage imageNamed:@"39-circle-check.png"];
        circleImageView.alpha = 1.0;
    } else {
        
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        circleImageView.image = [UIImage imageNamed:@"33-circle-plus.png"];
        circleImageView.alpha = 0.7;
    }

}

@end
