//
//  PhotoShareViewController.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoShareViewController : UITableViewController {
    NSString *where;
    NSString *what;
    UIScrollView *outerScroll;
}

@property (nonatomic, retain) NSString *where;
@property (nonatomic, retain) NSString *what;
@property (nonatomic, retain) UIScrollView *outerScroll;

- (id)initWithWhere:(NSString *)where_passed andWhat:(NSString *)what_passed;

@end
