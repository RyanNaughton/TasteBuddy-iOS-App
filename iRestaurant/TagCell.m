//
//  TagCell.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 25/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TagCell.h"
#import "Tag.h"

@implementation TagCell
@synthesize tag;
@synthesize service;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDelegate:(id<TaggingServiceDelegate>)delegate
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.font = [UIFont systemFontOfSize:13];
        service = [[TaggingService alloc] initWithDelegate:delegate];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadTag:(Tag *)tagPassed {
    tag = [tagPassed retain];
    self.textLabel.text = [NSString stringWithFormat:@"%@ (%i)", [tag.name retain], tag.count];
    if(tag.isUserTag) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"19-check.png"]];
        self.accessoryView = imageView;
        [imageView release];
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"13-plus.png"]];
        self.accessoryView = imageView;
        [imageView release];
    }
}

- (void)dealloc
{
    [tag release];
    [super dealloc];
}

@end
