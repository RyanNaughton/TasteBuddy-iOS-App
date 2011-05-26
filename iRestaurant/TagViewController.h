//
//  TagViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 26/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagsTableViewController;
@class TaggedObject;

@interface TagViewController : UIViewController {
    IBOutlet TagsTableViewController *tagsTableViewController;
    TaggedObject *taggedObject;
    
}
@property (nonatomic, retain) IBOutlet TagsTableViewController *tagsTableViewController;
@property (nonatomic, retain) TaggedObject *taggedObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTaggedObject:(TaggedObject *)taggedObjectPassed;

@end
