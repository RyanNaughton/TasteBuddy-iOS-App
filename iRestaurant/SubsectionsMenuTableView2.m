//
//  SubsectionsMenuTableView2.m
//  iRestaurant
//
//  Created by Josh Timonen on 6/10/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SubsectionsMenuTableView2.h"
#import "Menu.h"
#import "MenuCategory.h"
#import "MenuSubcategory.h"
#import "DishCell.h"
#import "MenuItem.h"
#import "DishViewController.h"

@implementation SubsectionsMenuTableView2

@synthesize menuCategory, simpleMenuItemArray, navController, restaurant, festival;


-(id)initWithMenuCategory:(MenuCategory *)menu_category_passed andFestival:(Festival *) festival_passed {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        menuCategory = [menu_category_passed retain];
        if (festival_passed) festival = [festival_passed retain];
        }
    return self;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
	return 70;
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
    
    UILabel *subcategoryName = [[UILabel alloc]initWithFrame:CGRectMake(10, -1, 220, 22)];
    subcategoryName.backgroundColor = [UIColor clearColor];
    subcategoryName.textColor = [[UIColor alloc]initWithRed:83.0/255.0 green:55.0/255.0 blue:2.0/255.0 alpha:1.0];
    subcategoryName.font = [UIFont systemFontOfSize:14];
    MenuSubcategory *menuSubcategory = (MenuSubcategory *)[menuCategory.menuSubcategories objectAtIndex:section];
    subcategoryName.text = [NSString stringWithFormat:@"%@", menuSubcategory.name];
    [headerView addSubview:subcategoryName];
    [subcategoryName release];
    return [headerView autorelease];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [menuCategory.menuSubcategories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MenuSubcategory *menuSubcategory = (MenuSubcategory *)[menuCategory.menuSubcategories objectAtIndex:section];
    return [menuSubcategory.arrayOfMenuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DishCell *dishCell = (DishCell *)[tableView dequeueReusableCellWithIdentifier:@"DishCell"];
    if (dishCell == nil) {
        dishCell = [[[DishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishCell"] autorelease];
    }
    MenuSubcategory *menuSubcategory = (MenuSubcategory *)[menuCategory.menuSubcategories objectAtIndex:indexPath.section];
    MenuItem *menuItem = (MenuItem *)[menuSubcategory.arrayOfMenuItems objectAtIndex:indexPath.row];
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
    MenuSubcategory *menuSubcategory = (MenuSubcategory *)[menuCategory.menuSubcategories objectAtIndex:indexPath.section];
    MenuItem *menuItem = (MenuItem *)[menuSubcategory.arrayOfMenuItems objectAtIndex:indexPath.row];
    DishViewController *dishViewController = [[DishViewController alloc]initWithMenuItem:menuItem andRestaurant:restaurant andFestival:festival];
    [self.navigationController pushViewController:dishViewController animated:YES];
    [dishViewController release];
}

@end
