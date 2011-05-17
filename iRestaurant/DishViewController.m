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
#import "Comment.h"
#import "TakePhoto.h"
#import "iRestaurantAppDelegate.h"
#import "RatingService.h"
#import "AuthenticationResponse.h"
#import "BookmarkService.h"
#import "Rating.h"
#import "RatingPopupViewController.h"

// CELLS
#import "DishHeaderCell.h"
#import "DishButtonsCell.h"
#import "RestaurantAddressCell.h"
#import "RestaurantPhoneCell.h"
#import "TagsCell.h"
#import "CommentsHeaderCell.h"
#import "CommentCell.h"

#import "CellUtility.h"

@implementation DishViewController

@synthesize restaurant, menu_item, tableArray, takePhoto;

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
        tableArray = [[NSMutableArray alloc]initWithObjects:@"Header", @"Buttons", @"Tags", @"Comments", nil];
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
    
    takePhoto = [[TakePhoto alloc]initWithParentViewController:self];
    
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tasteBuddyLogo.png"]];
    appNameImageView.frame = CGRectMake(0, -3, 320, 44);
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
            [dishHeaderCell loadMenuItem:menu_item andRestaurant:restaurant];
        }          
		return dishHeaderCell;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Buttons"]) {
        DishButtonsCell *dishButtonsCell = (DishButtonsCell *)[tableView dequeueReusableCellWithIdentifier:@"DishButtonsCell"];
		if (dishButtonsCell == nil) {
		    dishButtonsCell = [[[DishButtonsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishButtonsCell" andParentView:self] autorelease];
		}          
        //[dishButtonsCell loadRestaurant:restaurant];
		return dishButtonsCell;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        TagsCell *dishTagsCell = (TagsCell *)[tableView dequeueReusableCellWithIdentifier:@"DishTagsCell"];
		if (dishTagsCell == nil) {
		    dishTagsCell = [[[TagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishTagsCell"] autorelease];
		}          
        [dishTagsCell loadMenuItem:menu_item];
		return dishTagsCell;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Comments"]) {
        if(indexPath.row == 0) {
            CommentsHeaderCell *commentsHeaderCell = (CommentsHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentsHeaderCell"];
            if (commentsHeaderCell == nil) {
                commentsHeaderCell = [[[CommentsHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentsHeaderCell"] autorelease];
            }          
            return commentsHeaderCell;
        } else if ([menu_item.comments count] > 0) {
            CommentCell *commentCell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
            if (commentCell == nil) {
                commentCell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentCell"] autorelease];
            }
            [commentCell loadComment:[menu_item.comments objectAtIndex:(indexPath.row - 1)]];
            return commentCell;
        } else {
            return nil;
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
    CGFloat height;
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
        height = 395.0;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Buttons"]) {
        height = 160.0;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        height = 200;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Comments"]) {
        if([menu_item.comments count] > 0 && indexPath.row > 0) {
            Comment * comment = (Comment *)[menu_item.comments objectAtIndex:(indexPath.row - 1)];
            height = [CellUtility cellHeightForString:comment.text withFrame:CGRectMake(10, 30, 310, 20) andBottomPadding:10.0];
        } else {
            height = 50;
        }
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
    [takePhoto loadPhotoForDish:menu_item andRestaurant:restaurant withView:self];    
    //[takePhoto loadPhotoForMenuItem:menu_item atRestaurant:restaurant];
}
-(void)menuButtonPressed:(id)sender
{
   // [self loadMenu];
}
-(void)bookmarkButtonPressed:(id)sender
{
    BookmarkService *bs = [[BookmarkService alloc]initWithDelegate:self];
    [bs bookmarkMenuItem:menu_item]; 
}

-(void)rateItButtonPressed:(id)sender 
{
    
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];    
    RatingPopupViewController *rpvc = [[RatingPopupViewController alloc]initWithCurrentRating:restaurant.rating.user_rating];
    rpvc.delegate = self;
    rpvc.view.alpha = 0.0;
    [appDelegate.tabBarController.view addSubview:rpvc.view];
    [rpvc animateIn];
}

-(void)startRatingServiceWithRating:(float)rating 
{
    RatingService *rrs = [[RatingService alloc] initWithDelegate:self];
    [rrs rateMenuItem:menu_item withRating:rating];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    float rating = 5 - buttonIndex * 1.0;
    if(rating > 0.0f) {
        RatingService *rrs = [[RatingService alloc] initWithDelegate:self];
        [rrs rateMenuItem:menu_item withRating:rating];
    }
}

-(void) doneRating:(Rating *) rating {
    menu_item.rating = rating;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

-(void) doneBookmarking:(NSDictionary *) status {
    
    if ([[status objectForKey:@"status"] isEqualToString:@"success"]) {
        NSString *messageString = [NSString stringWithFormat:@"You have successfully bookmarked this Menu item!"];
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

-(void) newImageLoaded:(NSDictionary *)dict_passed {
    NSLog(@"it made it! %@", dict_passed);
    [menu_item.pictures addObject:dict_passed];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    DishHeaderCell *dhc = (DishHeaderCell *)[self.tableView cellForRowAtIndexPath:indexPath]; 
    [dhc.viewForScrollView removeFromSuperview];
    [dhc loadMenuItem:menu_item andRestaurant:restaurant];
    //[self.tableView reloadData];
}

@end
