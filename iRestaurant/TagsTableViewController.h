//
//  TagsTableViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 26/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaggingService.h"
@class TaggedObject;

@interface TagsTableViewController : UITableViewController<TaggingServiceDelegate> {
    TaggedObject *taggedObject;
}
@property (nonatomic, retain) TaggedObject *taggedObject;

-(void) loadTaggedObject:(TaggedObject *) taggedObjectPassed;
@end
