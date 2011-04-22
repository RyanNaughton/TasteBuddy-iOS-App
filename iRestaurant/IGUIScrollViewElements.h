///
///  IGUIScrollViewElements.h
///
///  IGUILibrary
///
///  Created by Ondrej Rafaj on 8.4.10.
///
///  Copyright 2010 Home. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum {
	IGUIScrollViewElementsPositionLeft = 0,
	IGUIScrollViewElementsPositionRight = 1,
	IGUIScrollViewElementsPositionCenter = 2,
	IGUIScrollViewElementsPositionFull = 3
} IGUIScrollViewElementsPosition;

typedef enum {
	IGUIScrollViewElementsUILabel = 0,
	IGUIScrollViewElementsUITextField = 1,
	IGUIScrollViewElementsUIButton = 2,
	IGUIScrollViewElementsUIImage = 3
} IGUIScrollViewElementsType;

@interface IGUIScrollViewElements : NSObject {
	
	UIScrollView *scrollView;
	
	CGRect rectScrollView;
	
	int scrollWidth;
	int scrollHeight;
	
	int actualHeight;
	
	int actualSpacing;
	BOOL ownSpacing;
	
	BOOL globalClearColor;
	
	UIFont *defaultFontForLabels;
	UIFont *defaultFontForTextViews;
	
	NSMutableArray *elementsArray;
	
	UIColor *bcgColor;
	
	BOOL rememberPosition;
	NSString *positionIdentifier;
	
}

- (void)setWidth:(int)width andHeight:(int)height;

- (void)setSizeFromScrollView:(UIScrollView *)scView;

- (void)setBackGroudColor:(UIColor *)color;

- (void)enablePositionMemory;

- (void)enablePositionMemoryWithIdentifier:(NSString *)identifier;

- (void)setClearColorForElementsBackground:(BOOL)useClearColor;

- (void)setClearColorForElementsBackground;

- (void)setDefaultFontForUILabels:(UIFont *)font;

- (void)setDefaultFontForUITextView:(UIFont *)font;

- (void)setDefaultFontForAll:(UIFont *)font;

- (void)setSpacing:(int)spacing;

- (void)addSpacing:(int)spacing;

- (void)addDefaultSpacing;



- (void)addCustom:(UIView *)element alignedTo:(IGUIScrollViewElementsPosition)position;

- (void)addLabel:(UILabel *)label alignedTo:(IGUIScrollViewElementsPosition)position;

- (void)addTextView:(UITextView *)textView alignedTo:(IGUIScrollViewElementsPosition)position;

- (void)addButton:(UIButton *)button withTarget:(id)target andSelector:(SEL)selector alignedTo:(IGUIScrollViewElementsPosition)position;

- (void)addButtonWithTitle:(NSString *)title withTarget:(id)target andSelector:(SEL)selector alignedTo:(IGUIScrollViewElementsPosition)position;

- (void)addImage:(UIImage *)image alignedTo:(IGUIScrollViewElementsPosition)position;

- (void)addImage:(UIImage *)image withDescription:(NSString *)description inColor:(UIColor *)descriptionColor alignedTo:(IGUIScrollViewElementsPosition)position;



- (UIScrollView *)getWithPositionMemoryIdentifier:(NSString *)identifier;

- (UIScrollView *)get;


@end
