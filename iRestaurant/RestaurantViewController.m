//
//  RestaurantViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantViewController.h"
#import "Restaurant.h"
#import "MenuViewController.h"

// CELLS =========
#import "RestaurantHeaderCell.h"
#import "RestaurantMenuCell.h"
#import "RestaurantAddressCell.h"
#import "RestaurantPhoneCell.h"

@implementation RestaurantViewController
@synthesize tableArray, restaurant;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithRestaurant:(Restaurant *)restaurant_passed {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        self.navigationController.navigationBar.translucent = YES;
        restaurant = restaurant_passed;
        tableArray = [[NSMutableArray alloc]initWithObjects:@"Header", @"Menu", @"Address", @"Phone", @"Tags", @"Highlights", @"Comments", nil];
    }
    return self;
}

- (void)dealloc
{
    [tableArray release];
    [super dealloc];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
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
    restaurantNameTitle.frame = CGRectMake(-40,0,200,44);
    restaurantNameTitle.textColor = [UIColor whiteColor];
    restaurantNameTitle.backgroundColor = [UIColor clearColor];
    restaurantNameTitle.font = [UIFont boldSystemFontOfSize:15];
    restaurantNameTitle.text = restaurant.name;
    restaurantNameTitle.textAlignment = UITextAlignmentCenter;
    restaurantNameTitle.contentMode = UIViewContentModeCenter;

    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0,0,100,44);
    titleView.backgroundColor = [UIColor clearColor];
    [titleView addSubview:restaurantNameTitle];
    
    titleView.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = titleView;
    
    
//    [self setTitle:restaurant.name];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grain-bg.png"]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)loadLunchMenu 
{
    NSLog(@"load lunch menu in parent view");
    MenuViewController *menuViewController = [[MenuViewController alloc]initWithRestaurant:restaurant];
    [self.navigationController pushViewController:menuViewController animated:YES];
    [menuViewController release];
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
    return [tableArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cells...
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
        RestaurantHeaderCell *restaurantHeaderCell = (RestaurantHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantHeaderCell"];
		if (restaurantHeaderCell == nil) {
		    restaurantHeaderCell = [[[RestaurantHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantHeaderCell"] autorelease];
		}          
        [restaurantHeaderCell loadRestaurant:restaurant];
		return restaurantHeaderCell;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Menu"]) {
        RestaurantMenuCell *restaurantMenuCell = (RestaurantMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantMenuCell"];
		if (restaurantMenuCell == nil) {
		    restaurantMenuCell = [[[RestaurantMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantMenuCell"] autorelease];
		}          
        [restaurantMenuCell loadRestaurant:restaurant];
        restaurantMenuCell.parentView = self;
		return restaurantMenuCell;

    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
        RestaurantAddressCell *restaurantAddressCell = (RestaurantAddressCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantAddressCell"];
		if (restaurantAddressCell == nil) {
		    restaurantAddressCell = [[[RestaurantAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantAddressCell"] autorelease];
		}          
        [restaurantAddressCell loadRestaurant:restaurant];
		return restaurantAddressCell;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Phone"]) {
        RestaurantPhoneCell *restaurantPhoneCell = (RestaurantPhoneCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantPhoneCell"];
		if (restaurantPhoneCell == nil) {
		    restaurantPhoneCell = [[[RestaurantPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantPhoneCell"] autorelease];
		}          
        [restaurantPhoneCell loadRestaurant:restaurant];
		return restaurantPhoneCell;

    } else {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.textLabel.text = [tableArray objectAtIndex:indexPath.section];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
        height = 130;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Menu"]) {
        height = 60;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
        height = 46;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Phone"]) {
        height = 40;
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
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
    
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Menu"]) {
    
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
        NSString *addressString = [NSString stringWithFormat:@"%@ %@", restaurant.address_1, restaurant.address_2];
        addressString = [addressString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString *requestString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@&z=15", addressString];
        NSLog(@"address req string: %@", requestString);
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:requestString]];			

    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
        NSString *phoneNumberString = [NSString stringWithFormat:@"tel://%@", restaurant.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberString]];
    } 
    
}

@end
