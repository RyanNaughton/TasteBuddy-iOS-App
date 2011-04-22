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
        // Initialization code
//        [self addSubview:text];
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
    if (user_name == nil) {
        user_name = [[UILabel alloc] init];
    }

    user_name.frame = CGRectMake(0, 0, 320, 20);        
    user_name.textColor = [UIColor darkGrayColor];
    user_name.backgroundColor = [UIColor clearColor];
    user_name.font = [UIFont systemFontOfSize:16];
    
    //text = [[UILabel alloc] init];
    //text.frame = CGRectMake(0, 0, 320, 20);
    
    [self addSubview:user_name];

    comment = commentToLoad;
    user_name.text = comment.user_name;
    text.text = comment.text;
}

@end
