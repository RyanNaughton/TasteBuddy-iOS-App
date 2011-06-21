//
//  MenuItem.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaggedObject.h"

@class Rating;

@interface MenuItem : TaggedObject {
    NSString *_id;
    NSString *name;
    NSString *description;
    NSArray *photo_urls;
    NSMutableArray *comments;
    NSMutableArray *pictures;
    NSString *restaurant_id;
    NSString *restaurant_name;
    float price;
    Rating *rating;
    BOOL bookmark;
    NSString *foreign_name;
    float ticket_price;
    
}

@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *photo_urls;
@property (nonatomic, retain) NSMutableArray *comments;
@property (nonatomic, retain) NSMutableArray *pictures;
@property (nonatomic, retain) NSString *restaurant_id;
@property (nonatomic, retain) NSString *restaurant_name;
@property (nonatomic, assign) float price;
@property (nonatomic, retain) Rating *rating;
@property (nonatomic, assign) BOOL bookmark;
@property (nonatomic, retain) NSString *foreign_name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, assign) float ticket_price;

-(id) initWithDictionary:(NSDictionary *)menuItemDictionary;

@end
