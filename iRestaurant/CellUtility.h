//
//  CellUtility.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 25/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellUtility : NSObject {
    
}

+(CGFloat) widthOfString:(NSString *)string withFrame:(CGRect)frame andFont:(UIFont *)font;

+(CGFloat) cellHeightForString:(NSString *)string withFrame:(CGRect)frame andBottomPadding:(CGFloat) paddingBottom;

@end
