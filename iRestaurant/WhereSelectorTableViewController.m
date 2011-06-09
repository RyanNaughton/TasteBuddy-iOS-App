//
//  WhereSelectorTableViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 6/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "WhereSelectorTableViewController.h"
#import "Restaurant.h"
#import "SearchService.h"
#import "ASIFormDataRequest.h"

@implementation WhereSelectorTableViewController
@synthesize searchBar, unfilteredList, filteredList, ss, delegate, loading;

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
    [ss release];
    [unfilteredList release];
    [filteredList release];
    [super dealloc];
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
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
    
    CGPoint point = CGPointMake(0, 0);
    ss = [[SearchService alloc]initWithLocation:point withDelegate:self];
    [ss searchByTerm:@""];
    loading = TRUE;

}

-(void)searchFinished:(NSMutableArray *)restaurantsArray
{
    NSLog(@"search finished: %@", restaurantsArray);
    unfilteredList = [restaurantsArray retain];
    filteredList = [[NSMutableArray arrayWithArray:unfilteredList] retain];
    loading = FALSE;
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText length] > 0) {
        filteredList = [[NSMutableArray alloc] init];
        for (Restaurant *restaurant in unfilteredList) {
            if ([restaurant.name rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) [filteredList addObject:restaurant];
        }
    } else {
        filteredList = [[NSMutableArray arrayWithArray:unfilteredList] retain];
    }
    [self.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows;
    if ([filteredList count] > 0) 
    {
        rows = [filteredList count];
    } else {
        rows = 1;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if ([filteredList count] > 0) 
    {
        Restaurant *restaurant = [filteredList objectAtIndex:indexPath.row];
        cell.textLabel.text = restaurant.name;
    } else {
        if (loading) {
            cell.textLabel.text = @"Loading...";
        } else {
            cell.textLabel.text = @"No Restaurants Listed";
        }
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
    [delegate whereSelected:[filteredList objectAtIndex:indexPath.row]];
}

@end
