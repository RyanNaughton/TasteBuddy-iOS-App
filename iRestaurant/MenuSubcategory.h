//
//  MenuSubsection.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 20/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MenuSubcategory : NSObject {
    NSMutableArray *arrayOfMenuItems;
    NSString *name;
}

@property (nonatomic, retain) NSMutableArray *arrayOfMenuItems;
@property (nonatomic, retain) NSString *name;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
