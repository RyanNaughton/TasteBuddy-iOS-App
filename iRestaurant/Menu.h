//
//  Menu.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Menu : NSObject {
    NSMutableArray *categories;
}

-(id)initWithDictionary:(NSDictionary *)menuDictionary;

@property (nonatomic, retain) NSMutableArray *categories;

@end
