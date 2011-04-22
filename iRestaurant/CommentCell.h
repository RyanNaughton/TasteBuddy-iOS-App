//
//  CommentCell.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 22/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;

@interface CommentCell : UITableViewCell {
    Comment *comment;
    UILabel *user_name;
    UILabel *text;
}

@property (nonatomic, retain) Comment *comment;
@property (nonatomic, retain) UILabel *user_name;
@property (nonatomic, retain) UILabel *text;

-(void) loadComment:(Comment *)commentToLoad;

@end
