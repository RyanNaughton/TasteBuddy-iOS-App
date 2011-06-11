//
//  SectionsMenuTableView2.m
//  iRestaurant
//
//  Created by Josh Timonen on 6/10/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SectionsMenuTableView2.h"
#import "Menu.h"
#import "MenuCategory.h"
#import "MenuSubcategory.h"
#import "SubsectionsMenuTableView.h"
#import "Restaurant.h"
#import "MenuViewController.h"
#import "MenuItemsViewController.h"
#import "SubsectionsMenuTableView2.h"

#import "CategoryCell.h"
#import "SubCategoryCell.h"

@implementation SectionsMenuTableView2

@synthesize menu, navController, restaurant, sectionExpanded, parentVC, isExpanded;


-(id)initWithMenu:(Menu *)menu_passed {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        menu = [menu_passed retain];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menu.arrayOfCategories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    
    CategoryCell *categoryCell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (categoryCell == nil) {
        categoryCell = [[[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.row];
    categoryCell.name.text = [NSString stringWithFormat:@"%@", menuCategory.name];
    
    int menuItemsCount = 0;
    for (MenuSubcategory *menuSubcategory in menuCategory.menuSubcategories) {
        menuItemsCount = menuItemsCount + [menuSubcategory.arrayOfMenuItems count];
        NSLog(@"subcat name: %@ | count: %i", menuSubcategory.name, [menuSubcategory.arrayOfMenuItems count]);
        NSLog(@"menu items count: %i", menuItemsCount);
    }
    
    categoryCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    categoryCell.count.text = [NSString stringWithFormat:@"(%i)", menuItemsCount];
    
    return categoryCell;
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
    MenuCategory *mc = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.row];
    [parentVC.tableView deselectRowAtIndexPath:indexPath animated:YES];
    SubsectionsMenuTableView2 *ss = [[SubsectionsMenuTableView2 alloc]initWithMenuCategory:mc];
    [ss setTitle:mc.name];
    ss.restaurant = [restaurant retain];
    [navController pushViewController:ss animated:YES];
    [ss release];
}

@end
