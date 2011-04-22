//
//  MenuItem.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MenuItem : NSObject <NSCopying> {
    NSNumber *_id;
    NSString *name;
    NSNumber *average_rating;
    NSArray *tags;
    NSArray *photo_urls;
    NSMutableArray *comments;
    NSArray *pictures;
    NSNumber *restaurant_id;
}

@property (nonatomic, retain) NSNumber *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *average_rating;
@property (nonatomic, retain) NSArray *tags;
@property (nonatomic, retain) NSArray *photo_urls;
@property (nonatomic, retain) NSMutableArray *comments;
@property (nonatomic, retain) NSArray *pictures;
@property (nonatomic, retain) NSNumber *restaurant_id;

-(id) initWithDictionary:(NSDictionary *)menuItemDictionary;

@end
