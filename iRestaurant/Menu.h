//
//  Menu.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Menu : NSObject {
    NSMutableArray *arrayOfCategories;
}

@property (nonatomic, retain) NSMutableArray *arrayOfCategories;

-(id)initWithArray:(NSArray *)array;

@end
