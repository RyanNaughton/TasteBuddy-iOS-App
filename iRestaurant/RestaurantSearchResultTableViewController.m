//
//  RestaurantSearchResultTableViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantSearchResultTableViewController.h"
#import "Restaurant.h"
#import "RestaurantSearchCell.h"
#import "SearchViewController.h"
#import "RestaurantViewController.h"
#import "iRestaurantAppDelegate.h"

@implementation RestaurantSearchResultTableViewController

@synthesize restaurantsArray;
@synthesize filteredArray;
@synthesize isLoading;
@synthesize searchViewController;
@synthesize filterText;

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
    [filteredArray release];
    [searchViewController release];
    [filterText release];
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
    self.tableView.backgroundColor = [UIColor clearColor];
    restaurantsArray = [[NSMutableArray alloc] init];
    filteredArray = [[NSMutableArray alloc] init];
    isLoading = YES;
    filterText = @"";
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (isLoading) {
        return 1;
    } else if ([filteredArray count] > 0 && !isLoading) {
        return [filteredArray count];
    } else {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView;
    NSLog(@"filter text length: %i", [filterText length]);
    if ([filterText length] != 0) {
        headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
        headerView.backgroundColor = [UIColor clearColor];
    
        UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grey-grad"]];
        bgImageView.alpha = 0.66;
        bgImageView.frame = headerView.frame;
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        [headerView addSubview:bgImageView];
        [bgImageView release];
    
        UILabel *restaurantName = [[UILabel alloc]initWithFrame:CGRectMake(10, -1, 300, 22)];
        restaurantName.backgroundColor = [UIColor clearColor];
        restaurantName.textColor = [UIColor whiteColor];
        restaurantName.font = [UIFont systemFontOfSize:14];
        restaurantName.text = filterText;
        restaurantName.shadowColor = [UIColor blackColor];
        restaurantName.shadowOffset = CGSizeMake(0,1);
        [headerView addSubview:restaurantName];
        [restaurantName release];
    } else {
        headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
        
    return [headerView autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    int height;
    
    if ([filterText length] != 0) {
        height = 22;
    } else {
        height = 0;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	if (isLoading) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadingCell"];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoadingCell"] autorelease];
            }          
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"Loading...";
            UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [act startAnimating];
            act.frame = CGRectMake(0, 0, 30, 30);
            act.center = CGPointMake(cell.contentView.center.x, 200);
            [cell.contentView addSubview:act];
            [act release];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else if ([filteredArray count] > 0) {
        
		RestaurantSearchCell *restaurantSearchCell = (RestaurantSearchCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantSearchCell"];
		if (restaurantSearchCell == nil) {
		    restaurantSearchCell = [[[RestaurantSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantSearchCell"] autorelease];
		}          
        
        [restaurantSearchCell loadRestaurant:[filteredArray objectAtIndex:indexPath.row]];
		
		return restaurantSearchCell;
    } else {
		
		static NSString *CellIdentifier = @"Placeholder Cell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
		    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		// Configure the cell...
		cell.textLabel.text = @"No Results";
        cell.textLabel.textColor = [UIColor darkGrayColor];
		
		return cell;
        
	}

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    if (isLoading) { 
        searchViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        height = 300; 
    } else if ([filteredArray count] > 0) {
        height = 52;
        searchViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        height = 50;
        searchViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    if([filteredArray count] > 0 && !isLoading){
    // Navigation logic may go here. Create and push another view controller.
    RestaurantViewController *restaurantViewController = [[RestaurantViewController alloc] initWithRestaurant:[filteredArray objectAtIndex:indexPath.row]];
    [searchViewController.navigationController pushViewController:restaurantViewController animated:YES];
    [restaurantViewController release];
    
    }

}

@end
