//
//  CommentCell.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 22/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "CommentCell.h"
#import "Comment.h"

@implementation CommentCell

@synthesize user_name, comment, text;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        user_name = [[UILabel alloc] init];
        text = [[UILabel alloc]init];
        [self addSubview:text];
        [self addSubview:user_name];

    }
    return self;
}

- (void)dealloc {
    [user_name release];
    [comment release];
    [text release];
    [super dealloc];
}

-(void) loadComment:(Comment *)commentToLoad {
    
    user_name.frame = CGRectMake(10, 0, 310, 20);        
    user_name.textColor = [UIColor darkGrayColor];
    user_name.backgroundColor = [UIColor clearColor];
    user_name.font = [UIFont systemFontOfSize:16];
    
    comment = commentToLoad;
    
    text.frame = CGRectMake(10, 30, 310, 20);   
    text.numberOfLines = 0;
    text.lineBreakMode = UILineBreakModeWordWrap;
    user_name.text = comment.user_name;
    text.text = comment.text;
    [text sizeToFit];
}

@end
