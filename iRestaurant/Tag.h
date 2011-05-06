//
//  Tag.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tag : NSObject {
    NSString *name;
    NSNumber *count;
    bool isUserTag;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *count;
@property (nonatomic, assign) bool isUserTag;

-(id) initWithTagValue:(NSString *) value;

@end
