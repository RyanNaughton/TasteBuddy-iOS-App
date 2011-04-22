//
//  DishViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishViewController.h"
#import "Restaurant.h"
#import "MenuItem.h"

// CELLS
#import "DishHeaderCell.h"
#import "DishButtonsCell.h"
#import "RestaurantAddressCell.h"
#import "RestaurantPhoneCell.h"
#import "DishTagsCell.h"
#import "DishCommentsCell.h"
#import "CommentCell.h"

@implementation DishViewController

@synthesize restaurant, menu_item, tableArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithMenuItem:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant_passed 
{    
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        self.tableView.backgroundColor = [UIColor whiteColor];
        tableArray = [[NSMutableArray alloc]initWithObjects:@"Header", @"Phone", @"Address", @"Tags", @"Comments", nil];
        menu_item = [menu_item_passed retain];
        restaurant = [restaurant_passed retain];
    }
    return self;
}

- (void)dealloc
{
    [restaurant release];
    [menu_item release];
    [tableArray release];
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
    [self setTitle:menu_item.name];
    
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iRestaurant-logo"]];
    appNameImageView.frame = CGRectMake(0, 0, 320, 35);
    appNameImageView.contentMode = UIViewContentModeRight;
    self.navigationItem.titleView = appNameImageView;
    self.tableView.separatorColor = [UIColor clearColor];
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
    if ([@"Comments" isEqualToString:[tableArray objectAtIndex:section]]) {
        return 1 + [menu_item.comments count];
    } else {
        return 1;        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
        DishHeaderCell *dishHeaderCell = (DishHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"DishHeaderCell"];
		if (dishHeaderCell == nil) {
		    dishHeaderCell = [[[DishHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishHeaderCell"] autorelease];
		}          
        [dishHeaderCell loadMenuItem:menu_item andRestaurant:restaurant];
		return dishHeaderCell;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Phone"]) {
        RestaurantPhoneCell *restaurantPhoneCell = (RestaurantPhoneCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantPhoneCell"];
		if (restaurantPhoneCell == nil) {
		    restaurantPhoneCell = [[[RestaurantPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantPhoneCell"] autorelease];
		}          
        [restaurantPhoneCell loadRestaurant:restaurant];
		return restaurantPhoneCell;

    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
        RestaurantAddressCell *restaurantAddressCell = (RestaurantAddressCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantAddressCell"];
		if (restaurantAddressCell == nil) {
		    restaurantAddressCell = [[[RestaurantAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantAddressCell"] autorelease];
		}          
        [restaurantAddressCell loadRestaurant:restaurant];
		return restaurantAddressCell;
   
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        NSLog(@"TAG CELL");
        DishTagsCell *dishTagsCell = (DishTagsCell *)[tableView dequeueReusableCellWithIdentifier:@"DishTagsCell"];
		if (dishTagsCell == nil) {
		    dishTagsCell = [[[DishTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishTagsCell"] autorelease];
		}          
        [dishTagsCell loadMenuItem:menu_item];
		return dishTagsCell;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Comments"]) {
        if(indexPath.row == 0) {
            DishCommentsCell *dishCommentsCell = (DishCommentsCell *)[tableView dequeueReusableCellWithIdentifier:@"DishCommentsCell"];
            if (dishCommentsCell == nil) {
                dishCommentsCell = [[[DishCommentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishCommentsCell"] autorelease];
            }          
            [dishCommentsCell loadMenuItem:menu_item];
            return dishCommentsCell;
        } else {
            CommentCell *commentCell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
            if (commentCell == nil) {
                commentCell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentCell"] autorelease];
            }
            [commentCell loadComment:[menu_item.comments objectAtIndex:(indexPath.row - 1)]];
            return commentCell;
        }
        
    } else {
        static NSString *CellIdentifier = @"Cell";
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
    
        // Configure the cell...
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = (NSString *)[tableArray objectAtIndex:indexPath.section];
    
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
        height = 355;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Buttons"]) {
        height = 60;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        height = 200;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Comments"]) {
        height = 100;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
        height = 45;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Phone"]) {
        height = 45;
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
    
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
    
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Phone"]) {
    
    } 
}

@end
