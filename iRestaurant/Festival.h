//
//  Festival.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Festival : NSObject
{
    NSNumber *_id;
    NSString *name;
    NSString *address_description;
    NSString *address_1;
    NSString *city_town;
    NSString *state_province;
    NSString *postal_code;
    NSString *website_url;
    NSString *start_date;
    NSString *end_date;
    NSNumber *latitude;
    NSNumber *longitude;
    float distance;
    NSDictionary *header_color;
    NSDictionary *logo;
}

@property (nonatomic, retain) NSNumber *_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address_description;
@property (nonatomic, retain) NSString *address_1;
@property (nonatomic, retain) NSString *city_town;
@property (nonatomic, retain) NSString *state_province;
@property (nonatomic, retain) NSString *postal_code;
@property (nonatomic, retain) NSString *website_url;
@property (nonatomic, retain) NSString *start_date;
@property (nonatomic, retain) NSString *end_date;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, assign) float distance;
@property (nonatomic, assign) NSDictionary *header_color;
@property (nonatomic, assign) NSDictionary *logo;

-(id) initWithDictionary:(NSDictionary *)festivalsDictionary;
-(NSString *) dates;
-(UIColor *) color;
-(NSString *) urlForDevice;
@end
