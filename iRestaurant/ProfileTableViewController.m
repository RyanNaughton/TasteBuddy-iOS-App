//
//  ProfileTableViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "ProfileHeadCell.h"
#import "ProfilePhotoDayTopCell.h"
#import "ProfilePhotoCell.h"
#import "iRestaurantAppDelegate.h"
#import "UserProfileService.h"

@implementation ProfileTableViewController
@synthesize ups, dataReceived, reviewsCount, picturesCount, username, picturesDictionary, picturesArray;

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
    [picturesDictionary release];
    [picturesArray release];
    [username release];
    [ups release];
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    UIBarButtonItem *settingsBtn = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
//                                                            style:UIBarButtonItemStyleBordered
//                                                           target:self
//                                                           action:@selector(settingsBtnPressed:)]; 
//    self.navigationItem.rightBarButtonItem = settingsBtn;
//    [settingsBtn release]; 
    
    UIBarButtonItem *logoutBtn = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(logoutPressed:)]; 
    self.navigationItem.leftBarButtonItem = logoutBtn;
    [logoutBtn release]; 
    
    

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
    ups = [[UserProfileService alloc]initWithDelegate:self];
    [ups getUserProfile];
}

-(void) doneRetrievingProfile:(NSMutableDictionary *) profile {
    NSLog(@"profile retrieved: %@", profile);
    reviewsCount = [[profile objectForKey:@"ratings_count"] intValue];
    picturesDictionary = [[NSDictionary alloc]initWithDictionary:[profile objectForKey:@"pictures"]];
    
    picturesArray = [[NSMutableArray alloc]init];
    picturesCount = 0;
    
    for (id key in picturesDictionary) {
        NSDictionary *dictOfDates = [picturesDictionary objectForKey:key];
        NSMutableArray *datesArray = [[NSMutableArray alloc]init];
        
        for (id key2 in dictOfDates) {
            NSArray *arrayOfImagesForRestaurant = [dictOfDates objectForKey:key2];
            picturesCount = [arrayOfImagesForRestaurant count] + picturesCount;
            NSDictionary *restaurantDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:arrayOfImagesForRestaurant, key2, nil];
            [datesArray addObject:restaurantDictionary];            
        }
        
        NSDictionary *dateDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:datesArray, key, nil];
        
        [picturesArray addObject:dateDictionary];
    }
    
    NSLog(@"pictures array: %@", picturesArray);
    
    username = @"Andrew Chalkley";
    dataReceived = TRUE;
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
    if (dataReceived) {
        int daysPhotosWereTaken = [picturesArray count];
        return (daysPhotosWereTaken + 1);
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowsInSection;
    if (dataReceived) {
        if (section == 0) {
            rowsInSection = 1;
        } else {
            NSDictionary *dict = [picturesArray objectAtIndex:(section - 1)];
            NSLog(@"dict %@", dict);
            NSArray *array;
            for (id key in dict) {
                array = [dict objectForKey:key];
            }
            
            rowsInSection = [array count] + 1;
        }
    } else {
        rowsInSection = 1;
    }
    
    return rowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataReceived) {
        
    if (indexPath.section == 0) {
        // Andrew Jackson
        // You've submitted 8 reviews
        // You've taken 18 pictures
        ProfileHeadCell *profileHeadCell = (ProfileHeadCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileHeadCell"];
		if (profileHeadCell == nil) {
		    profileHeadCell = [[[ProfileHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileHeadCell"] autorelease];
		}          
        [profileHeadCell setUserInfoWithName:username andReviews:reviewsCount andPictures:picturesCount];
		return profileHeadCell;

    }

    if (indexPath.section > 0) {
        // Sections of Days for photos
        
        if (indexPath.row == 0) {
            // photo date cell
            ProfilePhotoDayTopCell *profilePhotoDayTopCell = (ProfilePhotoDayTopCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfilePhotoDayTopCell"];
            if (profilePhotoDayTopCell == nil) {
                profilePhotoDayTopCell = [[[ProfilePhotoDayTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfilePhotoDayTopCell"] autorelease];
            }    
            NSDictionary *dict = [picturesArray objectAtIndex:(indexPath.section -1)];       
            NSString *dateString;
            for (id key in dict) {
                dateString = key;
            }
            [profilePhotoDayTopCell setDate:dateString];
            return profilePhotoDayTopCell;
        } else {
            // photo cell
            ProfilePhotoCell *profilePhotoCell = (ProfilePhotoCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfilePhotoCell"];
            if (profilePhotoCell == nil) {
                profilePhotoCell = [[[ProfilePhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfilePhotoCell"] autorelease];
            }  
            
            NSDictionary *dict = [picturesArray objectAtIndex:(indexPath.section - 1)];
            NSLog(@"dict %@", dict);
            NSArray *array;
            for (id key in dict) {
                array = [dict objectForKey:key];
            }
            
            NSDictionary *currentRestaurantDict = [array objectAtIndex:(indexPath.row -1)];
            NSLog(@"currentRestaurantDict: %@", currentRestaurantDict);
            [profilePhotoCell setVariablesWithDictionary:currentRestaurantDict];
            return profilePhotoCell;
        }

    }
        
    } else {
        // no data received yet
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadingCell"];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoadingCell"] autorelease];
        }          
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.text = @"Loading...";
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    
    if (indexPath.section == 0) {
        height = 130;
    } else {
        if (indexPath.row == 0) {
            // photo head
            height = 44;
        } else {
            height = 85;
        }
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

-(IBAction) logoutPressed:(id)sender {
    NSLog(@"Logout Pressed");
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate logout];
}

-(IBAction) settingsButtonPressed:(id)sender {
    
}

@end
