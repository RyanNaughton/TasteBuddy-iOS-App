//
//  CellUtility.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 25/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "StringSizeUtility.h"


@implementation StringSizeUtility

+(CGFloat) widthOfString:(NSString *)string withLabel:(UILabel *) labelPassed {
    UILabel *label = [[UILabel alloc] init];
    label.frame = labelPassed.frame;
    label.font = labelPassed.font;
    label.lineBreakMode = labelPassed.lineBreakMode;
    label.text = labelPassed.text;
    CGSize maximumLabelSize = CGSizeMake(label.frame.size.width,label.frame.size.height);
    CGSize expectedLabelSize = [string sizeWithFont:label.font 
                                  constrainedToSize:maximumLabelSize 
                                      lineBreakMode:label.lineBreakMode];
    [label release];
    return expectedLabelSize.width;
}

+(CGFloat) cellHeightForString:(NSString *)string withFrame:(CGRect)frame andBottomPadding:(CGFloat) paddingBottom{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    CGSize maximumLabelSize = CGSizeMake(frame.size.width,9999);
    CGSize expectedLabelSize = [string sizeWithFont:label.font 
                                      constrainedToSize:maximumLabelSize 
                                          lineBreakMode:label.lineBreakMode]; 


   
    frame.size.height = expectedLabelSize.height;
    label.frame = frame;
    [label release];
    return frame.origin.y + frame.size.height + paddingBottom;
}

@end
