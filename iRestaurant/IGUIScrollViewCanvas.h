///
///  IGUIScrollViewCanvas.h
///
///  IGUILibrary
///
///  Created by Ondrej Rafaj on 7.4.10.
///
///  Copyright 2010 Home. All rights reserved.
///
/// @todo enable margin and center the image to the middle of the view

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface IGUIScrollViewCanvas : NSObject <UIScrollViewDelegate> {
	
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	
	CGRect rectScrollView;
	CGRect rectPageControl;
	
	int scrollWidth;
	int scrollHeight;
	
	NSArray *contentArray;
	
	UIColor *bcgColor;
	
	BOOL pageControlEnabledTop;
	BOOL pageControlEnabledBottom;
	
	BOOL rememberPosition;
	NSString *positionIdentifier;
	
}

@property (nonatomic, retain) UIScrollView *scrollView;

- (int)getScrollViewWidth;

- (void)setWidth:(int)width andHeight:(int)height;

- (void)setSizeFromScrollView:(UIScrollView *)scView;

- (void)setBackGroudColor:(UIColor *)color;

- (void)setContentArray:(NSArray *)views;

- (void)enablePageControlOnTop;

- (void)enablePageControlOnBottom;

- (void)enablePositionMemory;

- (void)enablePositionMemoryWithIdentifier:(NSString *)identifier;

- (CGRect)getFrame;

- (UIScrollView *)getWithPosition:(int)page;

- (UIScrollView *)getWithPositionMemoryIdentifier:(NSString *)identifier;

- (UIScrollView *)get;

@end
