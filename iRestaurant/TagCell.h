//
//  TagCell.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 25/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaggingService.h"

@class Tag;

@interface TagCell : UITableViewCell {
    Tag *tag;
    TaggingService *service;
}

@property (nonatomic, retain) Tag *tag;
@property (nonatomic, retain) TaggingService *service;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDelegate:(id<TaggingServiceDelegate>)delegate;
-(void)loadTag:(Tag *)tagPassed;

@end
