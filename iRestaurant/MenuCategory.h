//
//  MenuCategory.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MenuCategory : NSObject {
    NSString *name;
    NSMutableArray *menuSubcategories;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *menuSubcategories;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
