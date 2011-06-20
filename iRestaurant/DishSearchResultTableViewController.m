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
#import "RatingView.h"
#import "RestaurantViewController.h"

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
    self.tableView.backgroundColor = [UIColor clearColor];
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
    if (isLoading) {
        return 1;
    } else if ([restaurantsArray count] > 0 && !isLoading) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!isLoading && [restaurantsArray count] > 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 37)];
        headerView.backgroundColor = [UIColor clearColor];
    
//        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
//        bgView.backgroundColor = [UIColor blackColor];
//        bgView.alpha = 0.66;
//        [headerView addSubview:bgView];
//        [bgView release];
        
        UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grey-grad.png"]];
        bgImageView.alpha = 0.95;
        bgImageView.frame = headerView.frame;
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        [headerView addSubview:bgImageView];
        [bgImageView release];

        UILabel *restaurantCuisine = [[UILabel alloc]initWithFrame:CGRectMake(10, -1, 220, 22)];
        restaurantCuisine.backgroundColor = [UIColor clearColor];
        restaurantCuisine.textColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255/255.0 blue:255.0/255.0 alpha:0.9];
        restaurantCuisine.font = [UIFont systemFontOfSize:11];
        restaurantCuisine.text = [[((Restaurant *)[restaurantsArray objectAtIndex:section]).cuisine_types objectAtIndex:0] retain];
        restaurantCuisine.shadowColor = [UIColor blackColor];
        restaurantCuisine.shadowOffset = CGSizeMake(0,1);
        [headerView addSubview:restaurantCuisine];
        [restaurantCuisine release];
        
        UILabel *restaurantName = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 220, 22)];
        restaurantName.backgroundColor = [UIColor clearColor];
        restaurantName.textColor = [UIColor whiteColor]; //[[UIColor alloc]initWithRed:83.0/255.0 green:55.0/255.0 blue:2.0/255.0 alpha:1.0];
        restaurantName.font = [UIFont systemFontOfSize:15];
        restaurantName.text = [((Restaurant *)[restaurantsArray objectAtIndex:section]).name retain];
        restaurantName.shadowColor = [UIColor blackColor];
        restaurantName.shadowOffset = CGSizeMake(0,1);
        [headerView addSubview:restaurantName];
        [restaurantName release];
    
        UILabel *distance = [[UILabel alloc]initWithFrame:CGRectMake(240, 13, 70, 22)];
        distance.backgroundColor = [UIColor clearColor];
        distance.textAlignment = UITextAlignmentRight;
        distance.textColor = [UIColor whiteColor]; //[[UIColor alloc]initWithRed:83.0/255.0 green:55.0/255.0 blue:2.0/255.0 alpha:1.0];
        distance.font = [UIFont systemFontOfSize:12];
        Restaurant *restaurant = [restaurantsArray objectAtIndex:section];
        distance.text = [NSString stringWithFormat:@"%@ miles", [restaurant.distance retain]];
        distance.shadowColor = [UIColor blackColor];
        distance.shadowOffset = CGSizeMake(0,1);
        [headerView addSubview:distance];
        [distance release];
        
        int starSize = 15;
        RatingView *ratingView = [[RatingView alloc] initWithStarSize:15 andLabelVisible:NO];
        ratingView.frame = CGRectMake((310 - (starSize * 5)), 2, (starSize * 5), 20); //CGRectMake(235, 2, 50, 20);
        [ratingView loadRating:restaurant.rating];
        [headerView addSubview:ratingView];
        
        UIButton *invisibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        invisibleButton.tag = section;
        invisibleButton.frame = headerView.frame;
        [invisibleButton addTarget:self action:@selector(headerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:invisibleButton];
        
        
        
        return [headerView autorelease];
    } else {
        return nil;
    }

}

-(void) headerButtonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSLog(@"header button pressed: %i", button.tag);
    
    if ([restaurantsArray count] > 0) {
        Restaurant *restaurant = (Restaurant *)[restaurantsArray objectAtIndex:button.tag];
        RestaurantViewController *restaurantViewController = [[RestaurantViewController alloc] initWithRestaurant:restaurant];
        [searchViewController.navigationController pushViewController:restaurantViewController animated:YES];
        [restaurantViewController release];
    }
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
    } else if ([restaurantsArray count] > 0) {
        
        MenuItem *menuItem = (MenuItem *)[((Restaurant *)[restaurantsArray objectAtIndex:indexPath.section]).menu_items objectAtIndex:indexPath.row];
        
        if ([menuItem.pictures count] > 0) {
            DishCell *dishCell = (DishCell *)[tableView dequeueReusableCellWithIdentifier:@"DishCell"];        
            if (dishCell == nil) {
                dishCell = [[[DishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishCell"] autorelease];
            }          
            [dishCell loadMenuItem:menuItem];
            return dishCell;
        } else {
            DishCell *dishCell = (DishCell *)[tableView dequeueReusableCellWithIdentifier:@"DishCellShort"];        
            if (dishCell == nil) {
                dishCell = [[[DishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishCellShort"] autorelease];
            }          
            [dishCell loadMenuItem:menuItem];
            return dishCell;
        }
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
    if (isLoading) { 
        searchViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        height = 300; 
    } else if ([restaurantsArray count] > 0) {
        MenuItem *menuItem = (MenuItem *)[((Restaurant *)[restaurantsArray objectAtIndex:indexPath.section]).menu_items objectAtIndex:indexPath.row];
        if ([menuItem.pictures count] > 0) {
            height = 70;
        } else {
            height = 48;
        }
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
    if ([restaurantsArray count] > 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        Restaurant *restaurant = (Restaurant *)[restaurantsArray objectAtIndex:indexPath.section];
        DishViewController *dishViewController = [[DishViewController alloc] initWithMenuItem:[restaurant.menu_items objectAtIndex:indexPath.row] andRestaurant:restaurant andFestival:searchViewController.festival];
        [searchViewController.navigationController pushViewController:dishViewController animated:YES];
        [dishViewController release];  
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
