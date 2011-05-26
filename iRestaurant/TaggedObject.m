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
    [self sortTags];
    NSMutableArray *names = [[NSMutableArray alloc] init];
    
    for(Tag *tag in tags) {
        if (tag.count > 0) {
            [names addObject:tag.name];            
        }
    }
    if([names count] > 0) {
        return [names componentsJoinedByString:@", "];
    } else {
        return @"Add a quick review!";
    }
}

-(void) addAllTags:(NSMutableArray *) tagsArray {
    NSMutableArray *existingTagNames = [[NSMutableArray alloc] init];
    for (Tag *tag in tags) {
        [existingTagNames addObject:tag.name];
    }
    if([existingTagNames count] > 0) {
        for (Tag *tag in tagsArray) { 
            NSUInteger i = [existingTagNames indexOfObject:tag.name];
            if (i < [tags count]) {
                Tag *existingTag = [tags objectAtIndex:i];
                tag.isUserTag = existingTag.isUserTag;
                tag.count = existingTag.count;                
            }
        }
    }
    tags = tagsArray;
    [self sortTags];
}

-(void) updateUserTags:(NSMutableArray *) tagsArray{
    //Reset Tags
    for (Tag *tag in tags) {
        tag.isUserTag = false;
        tag.count = 0;
    }
    NSMutableArray *tagValues = [[NSMutableArray alloc] init];
    for (Tag *tag in tags) {
        [tagValues addObject:tag.name];
    }
    //Update Tags
    for (Tag* tagForUser in tagsArray) {
        NSUInteger indexOfTag = [tagValues indexOfObject:tagForUser.name];
        Tag *tag = [tags objectAtIndex:indexOfTag];
        if([tag.name isEqualToString:tagForUser.name]) {
            tag.isUserTag = tagForUser.isUserTag;
            tag.count = tagForUser.count;
        }
    }
    [self sortTags];
}
-(void) sortTags {
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"count"
                                                                    ascending:NO] autorelease];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [tags sortedArrayUsingDescriptors:sortDescriptors];
    tags = [[NSMutableArray alloc] initWithArray:sortedArray];
}
@end
