//
//  SimpleMenuTableView.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SimpleMenuTableView.h"
#import "Menu.h"
#import "MenuCategory.h"
#import "MenuSubcategory.h"
#import "DishCell.h"
#import "MenuItem.h"
#import "DishViewController.h"

@implementation SimpleMenuTableView
@synthesize menu, simpleMenuItemArray, navController, restaurant;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithMenu:(Menu *)menu_passed {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        menu = [menu_passed retain];
        simpleMenuItemArray = [[NSMutableArray alloc]init];
        
        for (MenuCategory *category in menu.arrayOfCategories) {
            
            NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc]init];
            [categoryDictionary setObject:category.name forKey:@"name"];
            NSMutableArray *arrayOfMenuItems = [[NSMutableArray alloc]init];
            
            for (MenuSubcategory *subcategory in category.menuSubcategories) {
            
                for (MenuItem *menuItem in subcategory.arrayOfMenuItems) {
                    [arrayOfMenuItems addObject:menuItem];
                }
            
                [categoryDictionary setObject:arrayOfMenuItems forKey:@"items"];
            }
            [simpleMenuItemArray addObject:categoryDictionary];
        }
    }
    return self;
}

- (void)dealloc
{
    [menu release];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
	return 70;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"simpleMenuItemArray: %@", simpleMenuItemArray);
    return [simpleMenuItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    int rows = [[[simpleMenuItemArray objectAtIndex:section] objectForKey:@"items"] count];
//    MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:section];
//    for (MenuSubcategory *menuSubcategory in menuCategory.menuSubcategories) {
//        rows = rows + [menuSubcategory.arrayOfMenuItems count];
//    }
    
    NSLog(@"rows in section: %@", [[simpleMenuItemArray objectAtIndex:section] objectForKey:@"items"]);
    
    return [[[simpleMenuItemArray objectAtIndex:section] objectForKey:@"items"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//	NSString *header;
//	MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:section];
//    header = [NSString stringWithFormat:@"%@", menuCategory.name];
    NSString *header = @"";
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"orange-grad.png"]];
    bgImageView.alpha = 0.66;
    bgImageView.frame = headerView.frame;
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    [headerView addSubview:bgImageView];
    [bgImageView release];
    
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
//    bgView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:168.0/255.0 blue:0.0/255.0 alpha:1.0];
//    bgView.alpha = 0.66;
//    [headerView addSubview:bgView];
//    [bgView release];
    
    UILabel *restaurantName = [[UILabel alloc]initWithFrame:CGRectMake(10, -1, 220, 22)];
    restaurantName.backgroundColor = [UIColor clearColor];
    restaurantName.textColor = [[UIColor alloc]initWithRed:83.0/255.0 green:55.0/255.0 blue:2.0/255.0 alpha:1.0];
    restaurantName.font = [UIFont systemFontOfSize:14];
    restaurantName.text = [NSString stringWithFormat:@"%@", [[simpleMenuItemArray objectAtIndex:section] objectForKey:@"name"]];
    [headerView addSubview:restaurantName];
    [restaurantName release];
    return [headerView autorelease];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DishCell *dishCell = (DishCell *)[tableView dequeueReusableCellWithIdentifier:@"DishCell"];
    if (dishCell == nil) {
        dishCell = [[[DishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishCell"] autorelease];
    }
    
    MenuItem *menuItem = (MenuItem *)[[[simpleMenuItemArray objectAtIndex:indexPath.section] objectForKey:@"items"]objectAtIndex:indexPath.row];
    [dishCell loadMenuItem:menuItem];
    
    return dishCell;
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
    MenuItem *menuItem = (MenuItem *)[[[simpleMenuItemArray objectAtIndex:indexPath.section] objectForKey:@"items"]objectAtIndex:indexPath.row];
    DishViewController *dishViewController = [[DishViewController alloc]initWithMenuItem:menuItem andRestaurant:restaurant];
    [navController pushViewController:dishViewController animated:YES];
    [dishViewController release];
}

@end
