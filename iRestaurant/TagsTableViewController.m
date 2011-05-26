//
//  TagsTableViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 26/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TagsTableViewController.h"
#import "TaggedObject.h"
#import "TagCell.h"
#import "Restaurant.h"
#import "MenuItem.h"
#import "Tag.h"

@implementation TagsTableViewController

@synthesize taggedObject, filteredTags, searchBar;
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    taggedObject = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(taggedObject == nil) {
        return 0;
    } else {
        return [filteredTags count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TagCell";
    
    TagCell *cell = (TagCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andDelegate:self] autorelease];
    }
    [cell loadTag:[filteredTags objectAtIndex:indexPath.row]];    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   TagCell *tc = (TagCell *)[tableView cellForRowAtIndexPath:indexPath];
    if([taggedObject isKindOfClass:[Restaurant class]]) {
        if (tc.tag.isUserTag) {
            [tc.service deleteTagFromRestaurant:(Restaurant *)taggedObject withTag:tc.tag.name];
        } else {
            [tc.service tagRestaurant:(Restaurant *)taggedObject withTag:tc.tag.name];
        }
    } else {
        if (tc.tag.isUserTag) {
            [tc.service deleteTagFromMenuItem:(MenuItem *)taggedObject withTag:tc.tag.name];
        } else {
            [tc.service tagMenuItem:(MenuItem *)taggedObject withTag:tc.tag.name];
        }
        
    }
}

-(void) loadTaggedObject:(TaggedObject *) taggedObjectPassed {
    taggedObject = [taggedObjectPassed retain];
    [self searchBar:searchBar textDidChange:searchBar.text];
}

-(void) doneTagging:(NSMutableArray *)tagsFromUser {
    [taggedObject updateUserTags:tagsFromUser];
    filteredTags = [[NSMutableArray arrayWithArray:taggedObject.tags] retain];
    [self searchBar:searchBar textDidChange:searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText length] > 0) {
        filteredTags = [[NSMutableArray alloc] init];
        for (Tag *tag in taggedObject.tags) {
            if ([tag.name rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) [filteredTags addObject:tag];
        }
    } else {
        filteredTags = [[NSMutableArray arrayWithArray:taggedObject.tags] retain];
    }
    [self.tableView reloadData];
}


@end
