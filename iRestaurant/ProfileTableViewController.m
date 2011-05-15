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
#import "PhotoViewer.h"
#import "UserSettingsViewController.h"

@implementation ProfileTableViewController
@synthesize ups, dataReceived, reviewsCount, picturesCount, username, picturesDictionary, picturesArray, loading;

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
    
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"profileLogo.png"]];
    appNameImageView.frame = CGRectMake(0, -3, 150, 44);
    appNameImageView.contentMode = UIViewContentModeRight;
    self.navigationItem.titleView = appNameImageView;

    
        ups = [[UserProfileService alloc]initWithDelegate:self];
        [ups getUserProfile];
        loading = TRUE;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self checkLogin];    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) checkLogin {
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate loggedIn]) {
        
        UIBarButtonItem *settingsBtn = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(settingsBtnPressed:)]; 
        self.navigationItem.rightBarButtonItem = settingsBtn;
        [settingsBtn release];
        
        UIBarButtonItem *logoutBtn = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(logoutPressed:)]; 
        self.navigationItem.leftBarButtonItem = logoutBtn;
        [logoutBtn release]; 
        
    } else {
        UIBarButtonItem *loginBtn = [[UIBarButtonItem alloc] initWithTitle:@"Login"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(loginPressed:)]; 
        self.navigationItem.leftBarButtonItem = loginBtn;
        self.navigationItem.rightBarButtonItem = nil;
        [loginBtn release]; 
    }

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
    
    if (!animated) {
        ups = [[UserProfileService alloc]initWithDelegate:self];
        [ups getUserProfile];
        loading = TRUE;
    }
    
}

-(void) doneRetrievingProfile:(NSMutableDictionary *) profile {
        
    username = [[NSString stringWithFormat:@"%@",[profile objectForKey:@"username"]]retain];
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
            NSDictionary *restaurantDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:arrayOfImagesForRestaurant, @"array", key2, @"name", nil];
            [datesArray addObject:restaurantDictionary];            
        }
        
       
                        
        NSDictionary *dateDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:datesArray, @"array", key, @"date", nil];
        
        [picturesArray addObject:dateDictionary];
    }
     
    NSLog(@"picturesArray: %@", picturesArray);
    
    NSSortDescriptor *aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [picturesArray sortUsingDescriptors:[NSArray arrayWithObject:aSortDescriptor]];
    
    dataReceived = TRUE;
    loading = FALSE;
    [self checkLogin];
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
            NSArray *array = [dict objectForKey:@"array"];            
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
        [profileHeadCell setUserInfoWithName:[NSString stringWithFormat:@"%@", username] andReviews:reviewsCount andPictures:picturesCount];
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
            dateString = [dict objectForKey:@"date"];
            [profilePhotoDayTopCell setDate:dateString];
            return profilePhotoDayTopCell;
        } else {
            // photo cell
            ProfilePhotoCell *profilePhotoCell = (ProfilePhotoCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfilePhotoCell"];
            if (profilePhotoCell == nil) {
                profilePhotoCell = [[[ProfilePhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfilePhotoCell"] autorelease];
            }  
            
            NSDictionary *dict = [picturesArray objectAtIndex:(indexPath.section - 1)];
            NSArray *array = [dict objectForKey:@"array"];
            
            NSDictionary *currentRestaurantDict = [array objectAtIndex:(indexPath.row -1)];
            [profilePhotoCell setVariablesWithDictionary:currentRestaurantDict];
            return profilePhotoCell;
        }

    }
        
    } else {
        // no data received yet
        iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        if ([appDelegate loggedIn]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadingCell"];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoadingCell"] autorelease];
            }          
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"Loading...";
            UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [act startAnimating];
            act.frame = CGRectMake(0, 0, 30, 30);
            act.center = CGPointMake(cell.contentView.center.x, 200);
            [cell.contentView addSubview:act];
            [act release];
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoggedOutCell"];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoggedOutCell"] autorelease];
            }          
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"You are Logged Out.";
            return cell;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    int height;
    
    if ((dataReceived) && (!loading)) {
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
    } else {
        height = 300;
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
    if (indexPath.section > 0) {
        if (indexPath.row > 0) {
            NSDictionary *dict = [picturesArray objectAtIndex:(indexPath.section - 1)];
            NSArray *array = [dict objectForKey:@"array"];
            
            NSDictionary *currentRestaurantDict = [array objectAtIndex:(indexPath.row -1)];
            NSArray *arrayOfPhotos = [currentRestaurantDict objectForKey:@"array"];
            NSString *restaurantName = [currentRestaurantDict objectForKey:@"name"];
            
            NSMutableArray *arrayOfURLStrings = [[NSMutableArray alloc]init];
            for (NSDictionary *photoDict in arrayOfPhotos) {
                [arrayOfURLStrings addObject:[photoDict objectForKey:@"300px"]];
            }
            
            PhotoViewer *photoViewer = [[PhotoViewer alloc]init];            
            [photoViewer setupScrollView:arrayOfURLStrings];
            photoViewer.navItem.title = [NSString stringWithFormat:@"%@", restaurantName];
            photoViewer.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:photoViewer animated:YES];
            [photoViewer release];
        }
    }
}

-(IBAction) logoutPressed:(id)sender {
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate logout];
    dataReceived = FALSE;
    [self checkLogin];
    [self.tableView reloadData];
}

-(IBAction) loginPressed:(id)sender {
    ups = [[UserProfileService alloc]initWithDelegate:self];
    [ups getUserProfile];
    loading = TRUE;
    dataReceived = FALSE;
}

-(IBAction) settingsBtnPressed:(id)sender {
    UserSettingsViewController *usvc = [[UserSettingsViewController alloc]init];
    [self.navigationController pushViewController:usvc animated:YES];
    [usvc release];
}

@end
