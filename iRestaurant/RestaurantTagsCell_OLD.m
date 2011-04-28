//
//  RestaurantTagsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/20/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantTagsCell_OLD.h"

@implementation RestaurantTagsCell_OLD

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
            }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant {
    
    UILabel *tagsLabel = [[UILabel alloc]init];
    tagsLabel.frame = CGRectMake(10, 5, 50, 15);
    tagsLabel.textColor = [UIColor blackColor];
    tagsLabel.backgroundColor = [UIColor clearColor];
    tagsLabel.font = [UIFont boldSystemFontOfSize:14];
    tagsLabel.shadowColor = [UIColor whiteColor];
    tagsLabel.shadowOffset = CGSizeMake(0,1);
    tagsLabel.text = @"Tags";
    [self.contentView addSubview:tagsLabel];
    [tagsLabel release];
    
    // will have to replace this fake array with real tags passed in.
    NSArray *tags = [[NSArray alloc]initWithObjects:@"Spicy (3)", @"Tasty (5)", @"Grose (1)", @"Disgusting (2)", @"Amazing (15)", nil];
    
    int previousSizeWidth = 0;
    int line = 1;
    
    for (int i=0; i < [tags count]; i++) {
        
        UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *greyButtonImage = [[UIImage imageNamed:@"darkgrey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        [tagButton addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        NSString *tag = [tags objectAtIndex:i];
        [tagButton setTitle:tag forState:UIControlStateNormal];
        [tagButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
        [tagButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        tagButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        // Set tag positioning
        CGSize maximumLabelSize = CGSizeMake(800,800);
		CGSize size = [tag sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeWordWrap];
        if ((previousSizeWidth + size.width + 20) > 320) { line++; previousSizeWidth = 0; }
        tagButton.frame = CGRectMake((previousSizeWidth + 10), ((((size.height + 20) * line) + 10 - (size.height + 20)) + 15), (size.width + 10), (size.height + 10));
        [self.contentView addSubview:tagButton];
        previousSizeWidth = size.width + previousSizeWidth + 20;      
        
    }
}

+ (int) generateCellHeight {
    // will have to replace this fake array with real tags passed in.
    NSArray *tags = [[NSArray alloc]initWithObjects:@"Spicy (3)", @"Tasty (5)", @"Grose (1)", @"Disgusting(2)", @"Amazing (15)", nil];
    
    int previousSizeWidth = 0;
    int line = 1;
    int totalRowHeight = 0;
    
    for (int i=0; i < [tags count]; i++) {    
        // Set tag positioning
        NSString *tag = [tags objectAtIndex:i];
        CGSize maximumLabelSize = CGSizeMake(800,800);
		CGSize size = [tag sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeWordWrap];
        if ((previousSizeWidth + size.width + 20) > 320) { line++; previousSizeWidth = 0; }
        previousSizeWidth = size.width + previousSizeWidth + 20;      
        totalRowHeight = (((size.height + 20) * line) + 10 - (size.height + 20)) + (size.height + 10);
    }
    
    return (totalRowHeight + 20);
}

-(void)tagButtonPressed:(id)sender {
    UIButton *senderButton = (UIButton *)sender;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
