//
//  DishSearchResultTableViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishSearchResultTableViewController.h"
#import "Restaurant.h"
#import "MenuItem.h"
#import "SearchViewController.h"
#import "DishCell.h"
#import "DishViewController.h"

@implementation DishSearchResultTableViewController

@synthesize restaurantsArray;
@synthesize isLoading;

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
    [restaurantsArray release];
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
    restaurantsArray = [[NSMutableArray alloc] init];
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
    // Return the number of sections.
    if([restaurantsArray count] > 0 && !isLoading)
    {
        return [restaurantsArray count];
    } else {
        return 1;     
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if([restaurantsArray count] > 0 && !isLoading)
    {
    
        return [((Restaurant *)[restaurantsArray objectAtIndex:section]).menu_items count];
    } else {        
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!isLoading && [restaurantsArray count] > 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
        headerView.backgroundColor = [UIColor clearColor];
    
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.66;
        [headerView addSubview:bgView];
        [bgView release];
        
        UILabel *restaurantName = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 220, 22)];
        restaurantName.backgroundColor = [UIColor clearColor];
        restaurantName.textColor = [UIColor whiteColor];
        restaurantName.font = [UIFont systemFontOfSize:14];
        restaurantName.text = ((Restaurant *)[restaurantsArray objectAtIndex:section]).name;
        [headerView addSubview:restaurantName];
        [restaurantName release];
    
        UILabel *distance = [[UILabel alloc]initWithFrame:CGRectMake(240, 0, 70, 22)];
        distance.backgroundColor = [UIColor clearColor];
        distance.textAlignment = UITextAlignmentRight;
        distance.textColor = [UIColor whiteColor];
        distance.font = [UIFont systemFontOfSize:14];
        Restaurant *restaurant = [restaurantsArray objectAtIndex:section];
        distance.text = [NSString stringWithFormat:@"%@ mi", restaurant.distance];
        [headerView addSubview:distance];
        [distance release];
        return [headerView autorelease];
    } else {
        return nil;
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
    } else if ([restaurantsArray count] > 0) {
        
		DishCell *dishCell = (DishCell *)[tableView dequeueReusableCellWithIdentifier:@"DishCell"];
		if (dishCell == nil) {
		    dishCell = [[[DishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishCell"] autorelease];
		}          
        
        MenuItem *menuItem = (MenuItem *)[((Restaurant *)[restaurantsArray objectAtIndex:indexPath.section]).menu_items objectAtIndex:indexPath.row];
        [dishCell loadMenuItem:menuItem];
		
		return dishCell;
		
	} else {
		
		static NSString *CellIdentifier = @"Placeholder Menu Cell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
		    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		// Configure the cell...
		cell.textLabel.text = @"No Menu Items";
        cell.textLabel.textColor = [UIColor darkGrayColor];
		
		return cell;
        
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    if ([restaurantsArray count] > 0) {
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Restaurant *restaurant = (Restaurant *)[restaurantsArray objectAtIndex:indexPath.section];
    DishViewController *dishViewController = [[DishViewController alloc] initWithMenuItem:[restaurant.menu_items objectAtIndex:indexPath.row] andRestaurant:restaurant];
    [searchViewController.navigationController pushViewController:dishViewController animated:YES];
    [dishViewController release];  
    
    
}

@end
