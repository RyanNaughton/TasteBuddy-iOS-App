//
//  PhotoShareViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "PhotoShareViewController.h"
#import "PhotoShareTextCell.h"

@implementation PhotoShareViewController
@synthesize where, what, outerScroll;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithWhere:(NSString *)where_passed andWhat:(NSString *)what_passed
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        NSLog(@"init");
        // Custom initialization
        where = [where_passed retain];
        what = [what_passed retain];
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
    
    NSLog(@"view did load");

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows;
    if (section == 0) {
        rows = 3;
    } else if (section == 1) {
        rows = 1;
    }
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		return @"Details";
	} else if (section == 1) {
        return @"Sharing";
    } else {
        return nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // where
            PhotoShareTextCell *photoShareTextCell = (PhotoShareTextCell *)[tableView dequeueReusableCellWithIdentifier:@"PhotoShareTextCell-where"];
            if (photoShareTextCell == nil) {
                photoShareTextCell = [[[PhotoShareTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoShareTextCell-where"] autorelease];
            }          
            photoShareTextCell.outerScroll = outerScroll;
            photoShareTextCell.currentTextFieldRect = CGRectMake(0, 500, 10, 35);
            photoShareTextCell.textField.text = @"My Where String";
            photoShareTextCell.label.text = @"Where?";
            return photoShareTextCell;
        } else if (indexPath.row == 1) {
            // what
            PhotoShareTextCell *photoShareTextCell = (PhotoShareTextCell *)[tableView dequeueReusableCellWithIdentifier:@"PhotoShareTextCell-what"];
            if (photoShareTextCell == nil) {
                photoShareTextCell = [[[PhotoShareTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoShareTextCell-what"] autorelease];
            }          
            photoShareTextCell.outerScroll = outerScroll;
            photoShareTextCell.currentTextFieldRect = CGRectMake(0, 235, 10, 35);
            photoShareTextCell.textField.text = @"My What String";
            photoShareTextCell.label.text = @"What?";
            return photoShareTextCell;

        } else if (indexPath.row == 2) {
            // comments
            PhotoShareTextCell *photoShareTextCell = (PhotoShareTextCell *)[tableView dequeueReusableCellWithIdentifier:@"PhotoShareTextCell-comments"];
            if (photoShareTextCell == nil) {
                photoShareTextCell = [[[PhotoShareTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoShareTextCell-comments"] autorelease];
            }          
            photoShareTextCell.outerScroll = outerScroll;
            photoShareTextCell.currentTextFieldRect = CGRectMake(0, 280, 10, 35);
            photoShareTextCell.textField.text = @"My Comments String";
            photoShareTextCell.label.text = @"Comments:";
            return photoShareTextCell;

        }
    } else if (indexPath.section == 1) {
        // sharing
        if (indexPath.row == 0) {
            // facebook
            cell.textLabel.text = @"facebook";
        }
    } else {
        // do nothing
    }
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
