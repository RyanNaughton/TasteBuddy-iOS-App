//
//  MenuItemsViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/26/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuItemsViewController.h"
#import "MenuItem.h"
#import "Menu.h"
#import "MenuCategory.h"
#import "MenuSubcategory.h"
#import "DishCell.h"
#import "DishViewController.h"
#import "Restaurant.h"

@implementation MenuItemsViewController
@synthesize menu, menuSection, menuSubsection, restaurant, festival;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithMenu:(Menu *)menu_passed andSection:(int)section andSubsection:(int)subSection andRestaurant:(Restaurant *)restaurant_passed andFestival:(Festival *) festival_passed {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        menu = [menu_passed retain];
        menuSection = section;
        menuSubsection = subSection;
        restaurant = [restaurant_passed retain];
        if(festival_passed) {
            festival = [festival_passed retain];
        }
    }
    return self;
}

- (void)dealloc
{
    [festival release];
    [restaurant release];
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
    
    MenuCategory *menuCategory = [menu.arrayOfCategories objectAtIndex:menuSection];
    MenuSubcategory *menuSubcategory = [menuCategory.menuSubcategories objectAtIndex:menuSubsection];
    
    [self setTitle:menuSubcategory.name];

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
    [self.tableView reloadData];
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
    MenuCategory *menuCategory = [menu.arrayOfCategories objectAtIndex:menuSection];
    MenuSubcategory *menuSubcategory = [menuCategory.menuSubcategories objectAtIndex:menuSubsection];
    return [menuSubcategory.arrayOfMenuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCategory *menuCategory = [menu.arrayOfCategories objectAtIndex:menuSection];
    MenuSubcategory *menuSubcategory = [menuCategory.menuSubcategories objectAtIndex:menuSubsection];
    MenuItem *menuItem = [menuSubcategory.arrayOfMenuItems objectAtIndex:indexPath.row];
    
    DishCell *dishCell = (DishCell *)[tableView dequeueReusableCellWithIdentifier:@"DishCell"];
    if (dishCell == nil) {
        dishCell = [[[DishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishCell"] autorelease];
    }          
    
    [dishCell loadMenuItem:menuItem];
    return dishCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    MenuCategory *menuCategory = [menu.arrayOfCategories objectAtIndex:menuSection];
    MenuSubcategory *menuSubcategory = [menuCategory.menuSubcategories objectAtIndex:menuSubsection];
    MenuItem *menuItem = [menuSubcategory.arrayOfMenuItems objectAtIndex:indexPath.row];
    if ([menuItem.pictures count] > 0) {
        height = 70;
    } else {
        height = 48;
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
    MenuCategory *menuCategory = [menu.arrayOfCategories objectAtIndex:menuSection];
    MenuSubcategory *menuSubcategory = [menuCategory.menuSubcategories objectAtIndex:menuSubsection];
    MenuItem *menuItem = [menuSubcategory.arrayOfMenuItems objectAtIndex:indexPath.row];
    
    DishViewController *dishViewController = [[DishViewController alloc]initWithMenuItem:menuItem andRestaurant:restaurant andFestival:festival];
    [self.navigationController pushViewController:dishViewController animated:YES];
    [dishViewController release];
}

@end
