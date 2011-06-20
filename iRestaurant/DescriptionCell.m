//
//  DescriptionCell.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 20/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DescriptionCell.h"

@implementation DescriptionCell
@synthesize text;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code]
        text = [[UILabel alloc]init];
        text.frame = CGRectMake(10, 0, 310, 20);   
        text.numberOfLines = 0;
        text.font = [UIFont systemFontOfSize:12];
        text.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:text];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void) loadDescription:(NSString *)descriptionPassed {
    text.text = [descriptionPassed retain];
    [text sizeToFit];
}

-(void) dealloc {
    [text release];
    [super dealloc];
}

@end
