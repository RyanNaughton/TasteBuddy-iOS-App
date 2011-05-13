//
//  RestaurantViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//
#import "iRestaurantAppDelegate.h"
#import "RestaurantViewController.h"
#import "Restaurant.h"
#import "MenuViewController.h"
#import "TakePhoto.h"
#import "AuthenticationResponse.h"
#import "RatingService.h"
#import "BookmarkService.h"
#import "WebViewController.h"

// CELLS =========
#import "RestaurantHeaderCell.h"
#import "RestaurantMenuCell.h"
#import "RestaurantAddressCell.h"
#import "RestaurantPhoneCell.h"
#import "TagsCell.h"
#import "RestaurantWebsiteCell.h"
#import "RestaurantButtonsCell.h"


@implementation RestaurantViewController
@synthesize tableArray, restaurant, tagsRowHeight, takePhoto;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithRestaurant:(Restaurant *)restaurant_passed {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        self.navigationController.navigationBar.translucent = YES;
        restaurant = [restaurant_passed retain];
        tableArray = [[NSMutableArray alloc]initWithObjects:@"Header", @"Buttons", @"Tags", @"Comments", @"AdditionalInformation", @"WebsiteLink", nil];
        tagsRowHeight = 44;
    }
    return self;
}

- (void)dealloc
{
    [restaurant release];
    [tableArray release];
    [takePhoto release];
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
 
    takePhoto = [[TakePhoto alloc]initWithParentViewController:self];

    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iRestaurant-logo"]];
    appNameImageView.frame = CGRectMake(0, 0, 320, 35);
    appNameImageView.contentMode = UIViewContentModeRight;
    self.navigationItem.titleView = appNameImageView;
    
    self.tableView.separatorColor = [UIColor clearColor];
}

-(void)loadMenu 
{
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
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Buttons"]) {
        RestaurantButtonsCell *restaurantButtonsCell = (RestaurantButtonsCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantButtonsCell"];
		if (restaurantButtonsCell == nil) {
		    restaurantButtonsCell = [[[RestaurantButtonsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantButtonsCell" andParentView:self] autorelease];
		}          
        //[restaurantButtonsCell loadRestaurant:restaurant];
        //restaurantButtonsCell.parentView = self;
		return restaurantButtonsCell;

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
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        TagsCell *restaurantTagsCell = (TagsCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantTagsCell"];
		if (restaurantTagsCell == nil) {
		    restaurantTagsCell = [[[TagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantTagsCell"] autorelease];
		}          
        [restaurantTagsCell loadRestaurant:restaurant];
		return restaurantTagsCell;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"WebsiteLink"]) {
        RestaurantWebsiteCell *restaurantWebsiteCell = (RestaurantWebsiteCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantWebsiteCell"];
		if (restaurantWebsiteCell == nil) {
		    restaurantWebsiteCell = [[[RestaurantWebsiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantWebsiteCell" andRestaruantController:self] autorelease];
		}          
		return restaurantWebsiteCell;

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
        height = 180;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Buttons"]) {
        height = 160;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
        height = 45;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Phone"]) {
        height = 45;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        height = 200;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"WebsiteLink"]) {
        height = 48;
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
        
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
    
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Menu"]) {
    
    }
}

-(void)callButtonPressed:(id)sender
{
    NSString *phoneNumber = [restaurant.phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];    
    NSString *phoneNumberString = [NSString stringWithFormat:@"tel://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberString]];
}

-(void)mapItButtonPressed:(id)sender
{
    NSLog(@"map it pressed");
    NSString *addressString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@", restaurant.address_1, restaurant.address_2, restaurant.city_town, restaurant.state_province, restaurant.postal_code, restaurant.country];
    addressString = [addressString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *requestString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@&z=15", addressString];
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:requestString]];	

}
-(void)photoButtonPressed:(id)sender
{
    [takePhoto loadPhotoForRestaurant:restaurant];
}
-(void)menuButtonPressed:(id)sender
{
    [self loadMenu];
}
-(void)bookmarkButtonPressed:(id)sender
{
    BookmarkService *rbs = [[BookmarkService alloc]initWithDelegate:self];
    [rbs bookmarkRestaurant:restaurant];
}

-(void)websiteButtonPressed:(id)sender {
    if(![restaurant.website_url isKindOfClass:[NSNull class]]){
        WebViewController *wvc = [[WebViewController alloc] init];
        wvc.urlAddress = [restaurant.website_url retain];
        [self.navigationController pushViewController:wvc animated:YES];
        [wvc release];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unknown Website" message:[NSString stringWithFormat:@"Website for \"%@\" is missing.", restaurant.name] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(void) doneBookmarking:(NSDictionary *) status {
    if ([[status objectForKey:@"status"] isEqualToString:@"success"]) {
        NSString *messageString = [NSString stringWithFormat:@"You have successfully bookmarked this restaurant!"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Bookmark Saved!" message:messageString delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else  {
        NSString *messageString = [NSString stringWithFormat:@"We're sorry, but there was an error."];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:messageString delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } 
}

-(void) doneRating:(Rating *) rating {
    restaurant.rating = rating;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

-(void)rateItButtonPressed:(id)sender 
{
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"★★★★★", @"★★★★", @"★★★", @"★★", @"★", nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    [actionSheet showInView:appDelegate.tabBarController.view];
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    float rating = 5 - buttonIndex * 1.0;
    if(rating > 0.0f) {
        RatingService *rrs = [[RatingService alloc] initWithDelegate:self];
        [rrs rateRestaurant:restaurant withRating:rating];
    }
}

@end
