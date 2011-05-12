//
//  MenuItem.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MenuItem : NSObject {
    NSString *_id;
    NSString *name;
    NSNumber *average_rating;
    NSMutableArray *tags;
    NSArray *photo_urls;
    NSMutableArray *comments;
    NSArray *pictures;
    
    NSString *restaurant_id;
    
    NSString *price;
    
    NSString *tags_text;
}

@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *average_rating;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) NSArray *photo_urls;
@property (nonatomic, retain) NSMutableArray *comments;
@property (nonatomic, retain) NSArray *pictures;
@property (nonatomic, retain) NSString *restaurant_id;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *tags_text;

-(id) initWithDictionary:(NSDictionary *)menuItemDictionary;

@end
