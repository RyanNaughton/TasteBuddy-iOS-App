//
//  MenuViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuViewController.h"
#import "Restaurant.h"

@implementation MenuViewController
@synthesize restaurant;

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
    UILabel *restaurantNameTitle = [[UILabel alloc]init];
    restaurantNameTitle.frame = CGRectMake(0,0,100,25);
    restaurantNameTitle.textColor = [UIColor whiteColor];
    restaurantNameTitle.backgroundColor = [UIColor clearColor];
    restaurantNameTitle.font = [UIFont boldSystemFontOfSize:15];
    restaurantNameTitle.text = restaurant.name;
    restaurantNameTitle.textAlignment = UITextAlignmentCenter;
    
    UILabel *menuTitle = [[UILabel alloc]init];
    menuTitle.frame = CGRectMake(0,22,100,18);
    menuTitle.font = [UIFont boldSystemFontOfSize:13];
    menuTitle.textColor = [UIColor whiteColor];
    menuTitle.backgroundColor = [UIColor clearColor];
    menuTitle.text = @"menu";
    menuTitle.textAlignment = UITextAlignmentCenter;
    
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0,0,100,44);
    titleView.backgroundColor = [UIColor clearColor];
    [titleView addSubview:restaurantNameTitle];
    [titleView addSubview:menuTitle];
    
    titleView.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = titleView;

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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.66;
    [headerView addSubview:bgView];
    [bgView release];
    
    UILabel *restaurantName = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 240, 22)];
    restaurantName.backgroundColor = [UIColor clearColor];
    restaurantName.textColor = [UIColor whiteColor];
    restaurantName.text = @"Menu Section";
    [headerView addSubview:restaurantName];
    [restaurantName release];
    
//    UILabel *distance = [[UILabel alloc]initWithFrame:CGRectMake(260, 0, 50, 22)];
//    distance.backgroundColor = [UIColor clearColor];
//    distance.textColor = [UIColor whiteColor];
//    distance.text = @"0.2 mi";
//    [headerView addSubview:distance];
//    [distance release];
    
    return [headerView autorelease];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([restaurantsArray count] > 0) {
        
		DishesSearchCell *dishesSearchCell = (DishesSearchCell *)[tableView dequeueReusableCellWithIdentifier:@"DishesSearchCell"];
		if (dishesSearchCell == nil) {
		    dishesSearchCell = [[[DishesSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishesSearchCell"] autorelease];
		}          
        
        MenuItem *menuItem = (MenuItem *)[((Restaurant *)[restaurantsArray objectAtIndex:indexPath.section]).menu_items objectAtIndex:indexPath.row];
        [dishesSearchCell loadMenuItem:menuItem];
		
		return dishesSearchCell;
		
	} else {
		
		static NSString *CellIdentifier = @"Placeholder Menu Cell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
		    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		// Configure the cell...
		cell.textLabel.text = @"No Items";
        cell.textLabel.textColor = [UIColor darkGrayColor];
		
		return cell;
        
	}
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
