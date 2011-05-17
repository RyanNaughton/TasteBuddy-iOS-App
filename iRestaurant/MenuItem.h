//
//  MenuItem.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Rating;

@interface MenuItem : NSObject {
    NSString *_id;
    NSString *name;
    NSMutableArray *tags;
    NSArray *photo_urls;
    NSMutableArray *comments;
    NSMutableArray *pictures;
    
    NSString *restaurant_id;
    
    float price;
    
    NSString *tags_text;
    
    Rating *rating;
}

@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) NSArray *photo_urls;
@property (nonatomic, retain) NSMutableArray *comments;
@property (nonatomic, retain) NSMutableArray *pictures;
@property (nonatomic, retain) NSString *restaurant_id;
@property (nonatomic, assign) float price;
@property (nonatomic, retain) NSString *tags_text;
@property (nonatomic, retain) Rating *rating;

-(id) initWithDictionary:(NSDictionary *)menuItemDictionary;

@end
