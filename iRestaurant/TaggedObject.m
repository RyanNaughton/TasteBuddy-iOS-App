//
//  TaggedObject.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 18/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TaggedObject.h"
#import "Tag.h"


@implementation TaggedObject

@synthesize tags;

-(NSString *) tagsText {
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"count"
                                                                    ascending:NO] autorelease];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [tags sortedArrayUsingDescriptors:sortDescriptors];
    NSMutableArray *names = [[NSMutableArray alloc] init];
    
    for(Tag *tag in sortedArray) {
        if (tag.count > 0) {
            [names addObject:tag.name];            
        }
    }
    return [names componentsJoinedByString:@", "];
}

@end
