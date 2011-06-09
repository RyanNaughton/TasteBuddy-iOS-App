//
//  WhatSelectorTableViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 6/3/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "WhatSelectorTableViewController.h"
#import "Menu.h"
#import "MenuCategory.h"
#import "MenuSubcategory.h"
#import "MenuItem.h"
#import "Restaurant.h"

@implementation WhatSelectorTableViewController

@synthesize searchBar, unfilteredList, filteredList, delegate, ms, restaurant_id, loading;

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
    [unfilteredList release];
    [filteredList release];
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
}

-(void) callMenuService {
    ms = [[MenuService alloc]initWithDelegate:self];
    [ms getMenuForRestaurantID:restaurant_id];
    NSLog(@"restaurant id: %@", restaurant_id);
    loading = TRUE;
}

-(void)searchFinished:(NSMutableArray *)restaurantsArray
{
    NSLog(@"search finished: %@", restaurantsArray);
    unfilteredList = [restaurantsArray retain];
    filteredList = [[NSMutableArray arrayWithArray:unfilteredList] retain];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText length] > 0) {
        filteredList = [[NSMutableArray alloc] init];
        for (MenuItem *menuItem in unfilteredList) {
            if ([menuItem.name rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) [filteredList addObject:menuItem];
        }
    } else {
        filteredList = [[NSMutableArray arrayWithArray:unfilteredList] retain];
    }
    [self.tableView reloadData];
}

-(void)menuReturned:(Menu *)menu
{
    NSLog(@"menu returned: %@", menu);
    unfilteredList = [[NSMutableArray alloc]init];
    
    for (MenuCategory *category in menu.arrayOfCategories) {      
        NSLog(@"category: %@", category);
        for (MenuSubcategory *subcategory in category.menuSubcategories) {
            NSLog(@"subcategory: %@", subcategory);
            for (MenuItem *menuItem in subcategory.arrayOfMenuItems) {
                NSLog(@"menu item name: %@", menuItem.name);
                [unfilteredList addObject:menuItem];
            }
        }
    }
    filteredList = [[NSMutableArray arrayWithArray:unfilteredList] retain];
    NSLog(@"filtered list: %@", filteredList);
    NSLog(@"unfiltered list: %@", unfilteredList);
    loading = FALSE;
    [self.tableView reloadData];
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
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
    int rows;
    if ([filteredList count] > 0) 
    {
        rows = [filteredList count];
    } else {
        rows = 1;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if ([filteredList count] > 0) 
    {
        MenuItem *menuItem = [filteredList objectAtIndex:indexPath.row];
        cell.textLabel.text = menuItem.name;
    } else {
        if (loading == TRUE) {
            NSLog(@"loading text hit");
            cell.textLabel.text = @"Loading...";
        } else {
            cell.textLabel.text = @"No Menu Items Listed";
        }
    }
    
    return cell;
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
    if ((!loading) && ([filteredList count])) {
    [delegate whatSelected:[filteredList objectAtIndex:indexPath.row]];
    }
}

@end
