//
//  FavoritesRestaurantsTVC.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/6/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "FavoritesRestaurantsTVC.h"
#import "Restaurant.h"
#import "RestaurantSearchCell.h"
#import "FavoritesViewController.h"
#import "RestaurantViewController.h"
#import "iRestaurantAppDelegate.h"

@implementation FavoritesRestaurantsTVC

@synthesize restaurantsArray;
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
    [restaurantsArray release];
    [favoritesViewController release];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([restaurantsArray count] > 0 && !isLoading) {
        return [restaurantsArray count];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	if (isLoading) {
        iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        if ([appDelegate loggedIn]) {
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
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoggedOutCell"];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoggedOutCell"] autorelease];
            }          
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"You are Logged Out.";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if ([restaurantsArray count] > 0) {
        
		RestaurantSearchCell *restaurantSearchCell = (RestaurantSearchCell *)[tableView dequeueReusableCellWithIdentifier:@"FavoritesRestaurantSearchCell"];
		if (restaurantSearchCell == nil) {
		    restaurantSearchCell = [[[RestaurantSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FavoritesRestaurantSearchCell"] autorelease];
		}          
        
        [restaurantSearchCell loadRestaurant:[restaurantsArray objectAtIndex:indexPath.row]];
		
		return restaurantSearchCell;
    } else {
		
		static NSString *CellIdentifier = @"Placeholder Cell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
		    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		// Configure the cell...
		cell.textLabel.text = @"No Restaurant Favorites";
        cell.textLabel.textColor = [UIColor darkGrayColor];
		
		return cell;
        
	}
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    if (isLoading) { 
        favoritesViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        height = 300; 
    } else if ([restaurantsArray count] > 0) {
        height = 52;
        favoritesViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        height = 50;
        favoritesViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    if([restaurantsArray count] > 0 && !isLoading){
        // Navigation logic may go here. Create and push another view controller.
        RestaurantViewController *restaurantViewController = [[RestaurantViewController alloc] initWithRestaurant:[restaurantsArray objectAtIndex:indexPath.row]];
        [favoritesViewController.navigationController pushViewController:restaurantViewController animated:YES];
        [restaurantViewController release];
        
    }
    
}

@end
