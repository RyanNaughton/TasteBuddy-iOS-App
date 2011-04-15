//
//  MenuSubcategory.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MenuSubcategory : NSObject {
    NSMutableArray *menuItems;
    NSString *name;
}


-(id) initWithDictionary:(NSDictionary *) subcategoryDictionary;
@property (nonatomic,retain) NSMutableArray *menuItems;
@property (nonatomic,retain) NSString *name;

@end
