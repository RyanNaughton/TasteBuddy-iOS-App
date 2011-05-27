//
//  UILabelUnderlined.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "UILabelUnderlined.h"
#import "StringSizeUtility.h"

@implementation UILabelUnderlined

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    const float* colors = CGColorGetComponents( self.textColor.CGColor );
    CGContextSetRGBStrokeColor(ctx, colors[0]/255.0f, colors[1]/255.0f, colors[2]/255.0f, 1.0f); // RGBA
    CGContextSetLineWidth(ctx, 1.0f);
    
    CGContextMoveToPoint(ctx, 0, self.bounds.size.height - 1);

    CGContextAddLineToPoint(ctx, [StringSizeUtility widthOfString:self.text withFrame:self.frame andFont:self.font], self.bounds.size.height - 1);
    
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];  
}

@end
