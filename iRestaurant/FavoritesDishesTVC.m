//
//  FavoritesDishesTVC.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "FavoritesDishesTVC.h"
#import "MenuItem.h"
#import "FavoritesViewController.h"
#import "DishCell.h"
#import "DishViewController.h"


@implementation FavoritesDishesTVC

@synthesize dishesArray;
@synthesize isLoading;
@synthesize favoritesViewController;

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
    [dishesArray release];
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
    isLoading = YES;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if([dishesArray count] > 0 && !isLoading)
    {
        return [dishesArray count];
    } else {        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading) {
		static NSString *CellIdentifier = @"LoadingCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
		    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
        cell.textLabel.text = @"Loading...";
        UIActivityIndicatorView *documentActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [documentActivityIndicator startAnimating];
        [cell setAccessoryView:documentActivityIndicator];
        [documentActivityIndicator release];
        return  cell;        
    } else if ([dishesArray count] > 0) {
        
		DishCell *dishCell = (DishCell *)[tableView dequeueReusableCellWithIdentifier:@"FavoriteDishCell"];
		if (dishCell == nil) {
		    dishCell = [[[DishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FavoriteDishCell"] autorelease];
		}          
        
        MenuItem *menuItem = (MenuItem *)[dishesArray objectAtIndex:indexPath.row];
        [dishCell loadMenuItem:menuItem];
		
		return dishCell;
		
	} else {
		
		static NSString *CellIdentifier = @"Placeholder Menu Cell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
		    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		// Configure the cell...
		cell.textLabel.text = @"No Menu Item Favorites";
        cell.textLabel.textColor = [UIColor darkGrayColor];
		
		return cell;
        
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    if ([dishesArray count] > 0) {
        height = 70;
    } else {
        height = 44;
    }
    return height;
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
    if ([dishesArray count] > 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        DishViewController *dishViewController = [[DishViewController alloc] initWithMenuItem:[dishesArray objectAtIndex:indexPath.row] andRestaurant:nil];
        [favoritesViewController.navigationController pushViewController:dishViewController animated:YES];
        [dishViewController release];  
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
