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

@interface TagsTableViewController : UITableViewController<TaggingServiceDelegate, UISearchBarDelegate> {
    TaggedObject *taggedObject;
    NSMutableArray *filteredTags;
    IBOutlet UISearchBar *searchBar;
}
@property (nonatomic, retain) TaggedObject *taggedObject;
@property (nonatomic, retain) NSMutableArray *filteredTags;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

-(void) loadTaggedObject:(TaggedObject *) taggedObjectPassed;
@end
