//
//  TaggedObject.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 18/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TaggedObject : NSObject {
    NSMutableArray *tags;
}
@property (nonatomic, retain) NSMutableArray *tags;
-(NSString *) tagsText;
-(void) addAllTags:(NSMutableArray *) tagsArray;
-(void) updateUserTags:(NSMutableArray *) tagsArray;
-(void) sortTags;
@end
