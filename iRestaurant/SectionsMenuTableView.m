//
//  SectionsMenuTableView.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SectionsMenuTableView.h"
#import "Menu.h"
#import "MenuCategory.h"
#import "MenuSubcategory.h"
#import "SubsectionsMenuTableView.h"
#import "Restaurant.h"
#import "MenuViewController.h"
#import "MenuItemsViewController.h"

#import "CategoryCell.h"
#import "SubCategoryCell.h"

@implementation SectionsMenuTableView

@synthesize menu, navController, restaurant, sectionExpanded, parentVC, isExpanded;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithMenu:(Menu *)menu_passed {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        menu = [menu_passed retain];
    }
    return self;
}

- (void)dealloc
{
    [parentVC release];
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
    NSLog(@"viewdidappear");    
    [super viewDidAppear:animated];
    isExpanded = FALSE;   
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)]autorelease];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)]autorelease];
    return view;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [menu.arrayOfCategories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"SET ROWS!");
   
    int rows;
    
    if ((section == sectionExpanded) && (isExpanded)) {
         NSLog(@"section expanded: %i", sectionExpanded);
        
         MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:section];
        rows = [menuCategory.menuSubcategories count] + 1;
        
        //rows = 2;
    } else {
        rows = 1;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.row == 0) {
    
        static NSString *CellIdentifier = @"CategoryCell";
    
        CategoryCell *categoryCell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (categoryCell == nil) {
            categoryCell = [[[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
    
        MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.section];
        categoryCell.name.text = [NSString stringWithFormat:@"%@", menuCategory.name];
        
        
        if ((sectionExpanded == indexPath.section) && (isExpanded)) {
            categoryCell.accessoryType = UITableViewCellAccessoryNone;
        } else { 
            categoryCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            categoryCell.count.text = [NSString stringWithFormat:@"(%i)", [menuCategory.menuSubcategories count]];
        }
        return categoryCell;
        
    } else {
        // build subsection cell
        static NSString *CellIdentifier = @"SubCategoryCell";
        
        SubCategoryCell *subCategoryCell = (SubCategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (subCategoryCell == nil) {
            subCategoryCell = [[[SubCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.section];
        MenuSubcategory *menuSubCategory = (MenuSubcategory *)[menuCategory.menuSubcategories objectAtIndex:(indexPath.row -1)];
        subCategoryCell.name.text = [NSString stringWithFormat:@"%@", menuSubCategory.name];
        subCategoryCell.count.text = [NSString stringWithFormat:@"(%i)", [menuSubCategory.arrayOfMenuItems count]];
        subCategoryCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return subCategoryCell;

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
    [parentVC.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((indexPath.row == 0) && (!isExpanded)) {
        // expand section, when no others are expanded        
        isExpanded = TRUE;
        sectionExpanded = indexPath.section;    
        NSIndexSet *section = [NSIndexSet indexSetWithIndex:indexPath.section];
        [parentVC.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationFade];

    } else if ((indexPath.row == 0) && (isExpanded) && (indexPath.section != sectionExpanded)) {
        // collapse one, expand another
        isExpanded = TRUE;
        sectionExpanded = indexPath.section;
        NSIndexSet *allSections = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [menu.arrayOfCategories count])];
        [parentVC.tableView reloadSections:allSections withRowAnimation:UITableViewRowAnimationNone];
    
    } else if ((indexPath.row == 0) && (isExpanded) && (indexPath.section == sectionExpanded)) {
        // Collapse header
        isExpanded = FALSE;
        sectionExpanded = indexPath.section;
        NSIndexSet *section = [NSIndexSet indexSetWithIndex:indexPath.section];
        [parentVC.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationFade];
    } else {
        // go to menu list
        MenuItemsViewController *menuItemsViewController = [[MenuItemsViewController alloc]initWithMenu:menu andSection:indexPath.section  andSubsection:(indexPath.row - 1)];
        menuItemsViewController.restaurant = restaurant;
        [navController pushViewController:menuItemsViewController animated:YES];
        [menuItemsViewController release];
    }
}

@end
