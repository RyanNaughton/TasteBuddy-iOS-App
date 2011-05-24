///
///  IGUIScrollViewImage.h
///
///  IGUILibrary
///
///  Created by Ondrej Rafaj on 7.4.10.
///
///  Copyright 2010 Home. All rights reserved.
///
/// 


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IGUIScrollViewImageDelegate <NSObject>
-(void) setImageLabelsDishName:(NSString *)dishNameString andComment:(NSString *)commentString;
@end

@interface IGUIScrollViewImage : NSObject <UIScrollViewDelegate> {
	
    id <IGUIScrollViewImageDelegate> delegate;
    
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
    
    UILabel *menuItemLabel;
    BOOL showMenuItemLabel;
    NSArray *dishNameLabelArray;
    NSArray *commentLabelArray;
	
}

@property (nonatomic, retain) id <IGUIScrollViewImageDelegate> delegate;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *menuItemLabel;
@property (nonatomic, assign) BOOL showMenuItemLabel;
@property (nonatomic, retain) NSArray *dishNameLabelArray;
@property (nonatomic, retain) NSArray *commentLabelArray;

-(void)setDishNameLabelArray:(NSArray *)dishNameLabelArrayPassed andCommentLabelArray:(NSArray *)commentLabelArrayPassed;

/// returns width of the scollview
- (int)getScrollViewWidth;

/// set width and height for your final UIScrollView
- (void)setWidth:(int)width andHeight:(int)height;

/// set the exactly same size as it is your parent view
- (void)setSizeFromParentView:(UIScrollView *)scView;

/// set background color for your UIScrollView
- (void)setBackGroudColor:(UIColor *)color;

/// set an array with images you want to display in your new scroll view
- (void)setContentArray:(NSArray *)images;

/// display page control for the scroll view on the top of the view (inset)
- (void)enablePageControlOnTop;

/// display page control for the scroll view on the bottom of the view (inset)
- (void)enablePageControlOnBottom;

/// enable position history
- (void)enablePositionMemory;

/// enable position history with custom memory identifier
- (void)enablePositionMemoryWithIdentifier:(NSString *)identifier;

- (CGRect)getFrame;

/// returns your UIScrollView with predefined page
- (UIScrollView *)getWithPosition:(int)page;

/// returns your UIScrollView with enabled position history
- (UIScrollView *)getWithPositionMemory;

/// returns your UIScrollView with enabled position history with custom memory identifier
- (UIScrollView *)getWithPositionMemoryIdentifier:(NSString *)identifier;

/// returns your UIScrollView
- (UIScrollView *)get;

@end
