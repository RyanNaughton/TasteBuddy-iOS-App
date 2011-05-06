//
//  TagButton.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TagButton.h"
#import "RestaurantTaggingService.h"
#import "iRestaurantAppDelegate.h"
#import "AuthenticationResponse.h"

@implementation TagButton

@synthesize tag, tagName, circleImageView, circlePlus, circleCheck, greyButtonImage, restauarantTaggingService, restaurant;


-(void) loadTag:(Tag *) tagToLoad andRestaurant:(Restaurant *) restaurantToLoad {
    
    tag = tagToLoad;
    restaurant = restaurantToLoad;
    
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    tagName = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 110, 15)];
    tagName.backgroundColor = [UIColor clearColor];
    tagName.font = [UIFont systemFontOfSize:13];
    [self addSubview:tagName];
    
    
    circleImageView = [[UIImageView alloc]initWithImage:circlePlus];
    circleImageView.frame = CGRectMake(120, 7, 15, 15);
    circleImageView.alpha = 0.7;
    [self addSubview:circleImageView];
    [self refreshTag];
    
    restauarantTaggingService = [[RestaurantTaggingService alloc] initWithDelegate:self];
}

-(void)tagButtonPressed:(id)sender {
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    [restauarantTaggingService tagRestaurant:restaurant withTag:tag.name andAuthToken:appDelegate.authenticationResponse.authentication_token];
}


-(void) refreshTag {
    tagName.text = [NSString stringWithFormat:@"%@ (%@)", tag.name, tag.count];
    
    
    
    if (tag.isUserTag) {
        greyButtonImage = [[UIImage imageNamed:@"grey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        [self setBackgroundImage:greyButtonImage forState:UIControlStateNormal];

        circleCheck = [UIImage imageNamed:@"39-circle-check.png"];
        circleImageView.image = circleCheck;
        
    } else {
        
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        circlePlus = [UIImage imageNamed:@"33-circle-plus.png"];
        circleImageView.image = circlePlus;
    }

}

-(void) doneTagging:(NSMutableArray *) tagsFromUser {
    for (Tag* tagForUser in tagsFromUser) {
        if([tag.name isEqualToString:tagForUser.name]) {
            tag.isUserTag = true;
            tag.count = [NSNumber numberWithInteger:[tagForUser.count intValue]];
            break;
        }
    }
    [self refreshTag];
}

- (void)dealloc {
    [restaurant release];
    [restauarantTaggingService release];
    [tagName release];
    [circleImageView release];
    [tag release];
    [super dealloc];
}
@end
