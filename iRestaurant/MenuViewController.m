//
//  MenuViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuService.h"
#import "Restaurant.h"
#import "Menu.h"
#import "MenuCategory.h"
#import "MenuSubcategory.h"
#import "SimpleMenuTableView.h"
#import "SectionsMenuTableView.h"

@implementation MenuViewController
@synthesize restaurant, menuService, tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRestaurant:(Restaurant *)restaurant_passed 
{
    self = [super initWithNibName:@"MenuViewController" bundle:nil];
    if (self) {
        // Custom initialization
        restaurant = [restaurant_passed retain];
        menuService = [[MenuService alloc]initWithDelegate:self];
        [menuService getMenuForRestaurant:restaurant];
    }
    return self;
}

-(void)menuReturned:(Menu *)menu {
    NSLog(@"menu: %@", menu);
 //   restaurant.menu = [menu retain];
    
    int menuItems = 0;
    for (MenuCategory *menuCategory in menu.arrayOfCategories) {
        for (MenuSubcategory *menuSubcategory in menuCategory.menuSubcategories) {
            menuItems = menuItems + [menuSubcategory.arrayOfMenuItems count];
        }
    }
    
    NSLog(@"how many menu items: %i", menuItems);
    
    if (menuItems > 10) {
        SectionsMenuTableView *sectionsMenuTableView = [[SectionsMenuTableView alloc]initWithMenu:menu];
        tableView.dataSource = sectionsMenuTableView;
        tableView.delegate = sectionsMenuTableView;
        sectionsMenuTableView.navController = self.navigationController;
        sectionsMenuTableView.restaurant = restaurant;
        [tableView reloadData];
        //[sectionsMenuTableView release];
        
    } else {
        SimpleMenuTableView *simpleMenuTableView = [[SimpleMenuTableView alloc]initWithMenu:menu];
        tableView.dataSource = simpleMenuTableView;
        tableView.delegate = simpleMenuTableView;
        simpleMenuTableView.navController = self.navigationController;
        [tableView reloadData];
        //[simpleMenuTableView release];
    }
}

- (void)dealloc
{
    //[restaurant release];
    //[menuService release];
    //[tableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
