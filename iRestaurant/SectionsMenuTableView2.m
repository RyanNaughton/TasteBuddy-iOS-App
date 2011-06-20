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
#import "MenuItem.h"

@implementation SectionsMenuTableView2

@synthesize menu, navController, restaurant, sectionExpanded, parentVC, isExpanded, festival;


-(id)initWithMenu:(Menu *)menu_passed andFestival:(Festival*) festival_passed {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        menu = [menu_passed retain];
        if (festival_passed) {
            festival = [festival_passed retain];
        }
    }
    return self;
}

-(id)initWithMenu:(Menu *)menu_passed {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        menu = [menu_passed retain];
        festival = nil;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    if (indexPath.row == 0) {
        height = 44;
    } else {
        height = 35;
    }
    return height;
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
    return [menu.arrayOfCategories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows;
    MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:section];
    int menuItemsCount = 0;
    for (MenuSubcategory *menuSubcategory in menuCategory.menuSubcategories) {
        menuItemsCount = menuItemsCount + [menuSubcategory.arrayOfMenuItems count];
    }
    if (menuItemsCount > 100) {
        if ((section == sectionExpanded) && (isExpanded)) {
            MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:section];
            rows = [menuCategory.menuSubcategories count] + 1;
        } else {
            rows = 1;
        }
    } else {
        rows = 1;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.section];
    int menuItemsCount = 0;
    for (MenuSubcategory *menuSubcategory in menuCategory.menuSubcategories) {
        menuItemsCount = menuItemsCount + [menuSubcategory.arrayOfMenuItems count];
    }
    if ((menuItemsCount > 100) && (indexPath.row == 0)) {
        // header row for expanded view
        MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.section];
        static NSString *CellIdentifier = @"CategoryCellExpandedView";
        CategoryCell *categoryCell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (categoryCell == nil) {
            categoryCell = [[[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        categoryCell.accessoryType = UITableViewCellAccessoryNone;
        categoryCell.count.text = [NSString stringWithFormat:@"(%i)", menuItemsCount];
        categoryCell.name.text = menuCategory.name;
        return categoryCell;
    } else if ((menuItemsCount > 100) && (indexPath.row > 0)) {
        // sub row for expanded view
        MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.section];
        MenuSubcategory *menuSubcategory = (MenuSubcategory *)[menuCategory.menuSubcategories objectAtIndex:(indexPath.row - 1)];
        static NSString *CellIdentifier = @"SubCategoryCell";
        SubCategoryCell *subCategoryCell = (SubCategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (subCategoryCell == nil) {
            subCategoryCell = [[[SubCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        subCategoryCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        subCategoryCell.count.text = [NSString stringWithFormat:@"(%i)", [menuSubcategory.arrayOfMenuItems count]];
        subCategoryCell.name.text = menuSubcategory.name;
        return subCategoryCell;
    } else {
        // header row for non-expanded view
        MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.section];
        static NSString *CellIdentifier = @"CategoryCell";
        CategoryCell *categoryCell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (categoryCell == nil) {
            categoryCell = [[[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        categoryCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        categoryCell.count.text = [NSString stringWithFormat:@"(%i)", menuItemsCount];
        categoryCell.name.text = menuCategory.name;
        return categoryCell;
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MenuCategory *menuCategory = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.section];
    int menuItemsCount = 0;
    for (MenuSubcategory *menuSubcategory in menuCategory.menuSubcategories) {
        menuItemsCount = menuItemsCount + [menuSubcategory.arrayOfMenuItems count];
    }
    
    if ((menuItemsCount > 100) && (indexPath.row == 0)) {
       // header row for expanded view 
        if (!isExpanded) {
            // expand section, when no others are expanded
            isExpanded = TRUE;
            sectionExpanded = indexPath.section;    
            NSIndexSet *section = [NSIndexSet indexSetWithIndex:indexPath.section];
            [parentVC.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationFade];
        } else if (isExpanded && (indexPath.section != sectionExpanded)) {
            // collapse one, expand another
            isExpanded = TRUE;
            sectionExpanded = indexPath.section;
            NSIndexSet *allSections = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [menu.arrayOfCategories count])];
            [parentVC.tableView reloadSections:allSections withRowAnimation:UITableViewRowAnimationNone];
        } else {
            // Collapse header
            isExpanded = FALSE;
            sectionExpanded = indexPath.section;
            NSIndexSet *section = [NSIndexSet indexSetWithIndex:indexPath.section];
            [parentVC.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationFade];
        }
        
    } else if ((menuItemsCount > 100) && (indexPath.row > 0)) {
        // sub row for expanded view
        MenuItemsViewController *mivc = [[MenuItemsViewController alloc]initWithMenu:menu andSection:indexPath.section andSubsection:(indexPath.row -1) andRestaurant:restaurant andFestival:festival];
        [navController pushViewController:mivc animated:YES];
        [mivc release];

    } else {
        // header row for non-expanded view
        MenuCategory *mc = (MenuCategory *)[menu.arrayOfCategories objectAtIndex:indexPath.row];
        [parentVC.tableView deselectRowAtIndexPath:indexPath animated:YES];
        SubsectionsMenuTableView2 *ss = [[SubsectionsMenuTableView2 alloc]initWithMenuCategory:mc andFestival:festival];
        [ss setTitle:mc.name];
        ss.restaurant = [restaurant retain];
        [navController pushViewController:ss animated:YES];
        [ss release];
    }    
}

@end
