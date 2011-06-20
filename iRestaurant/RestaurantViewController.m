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
#import "StringSizeUtility.h"
#import "Comment.h"
#import "RatingPopupViewController.h"
#import "TagViewController.h"
#import "Rating.h"
#import "LoadingTagCell.h"
#import "TagCell.h"
#import "MoreTagsCell.h"
#import "Tag.h"
#import "CommentService.h"
#import "Menu.h"
#import "Festival.h"
#import "UIImageView+WebCache.h"

// CELLS =========
#import "RestaurantHeaderCell.h"
#import "RestaurantMenuCell.h"
#import "RestaurantAddressCell.h"
#import "RestaurantPhoneCell.h"
#import "QuickReviewHeaderCell.h"
#import "RestaurantWebsiteCell.h"
#import "RestaurantButtonsCell.h"
#import "CommentsHeaderCell.h"
#import "CommentCell.h"
#import "RestaurantAdditionalInformationCell.h"

@implementation RestaurantViewController
@synthesize tableArray, restaurant, tagsRowHeight, takePhoto, menuViewController, tagsBeingLoaded, tagService, festival;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithRestaurant:(Restaurant *)restaurant_passed andFestival:(Festival *)festival_passed {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        tagsBeingLoaded = true;
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        self.navigationController.navigationBar.translucent = YES;
        restaurant = [restaurant_passed retain];
        if (festival_passed) {
            festival = [festival_passed retain];
        }
        [self buildTableArray];
        
        tagsRowHeight = 44;
        tagService =[[TagService alloc] initWithDelegate:self];
        [tagService getTags];
    }
    return self;
}

-(void) buildTableArray {
    tableArray = [[NSMutableArray alloc]initWithObjects:@"Header", @"Buttons", nil];
    
    if (restaurant.menu_present) {
        [tableArray addObject:@"Menu"];
    }
    
    if (![restaurant.website_url isKindOfClass:[NSNull class]]) [tableArray addObject:@"WebsiteLink"];
    [tableArray addObject:@"AdditionalInformation"];
    //[tableArray addObject:@"Tags"];
    if ([restaurant.comments count] > 0) {
        [tableArray addObject:@"Comments"];
    }

}

- (void)dealloc
{
    [tagService release];
    [menuViewController release];
    //[restaurant release];
    [tableArray release];
    [takePhoto release];
    [festival release];
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
    menuViewController = [[MenuViewController alloc]initWithRestaurant:restaurant andFestival:festival];
    takePhoto = [[TakePhoto alloc]initWithParentViewController:self];

    self.tableView.separatorColor = [UIColor clearColor];
}

-(void)loadMenu 
{
    
    [self.navigationController pushViewController:menuViewController animated:YES];
    
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
    UIImageView *appNameImageView;
    if(festival) {
        self.navigationController.navigationBar.tintColor = festival.color;
        appNameImageView = [[UIImageView alloc] init];
        [appNameImageView setImageWithURL:[NSURL URLWithString:festival.urlForDevice]];
        appNameImageView.frame = CGRectMake(110, 0, 150, 44);
        appNameImageView.contentMode = UIViewContentModeScaleAspectFit;
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, -3, 320, 44)];
        [titleView addSubview:appNameImageView];
        self.navigationItem.titleView = titleView;
    } else {
        appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tasteBuddyLogo.png"]];
        appNameImageView.frame = CGRectMake(0, -3, 320, 44);
        appNameImageView.contentMode = UIViewContentModeRight;
        self.navigationItem.titleView = appNameImageView;
    }
    
    if(animated) {
        [self.tableView reloadData];
    }
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
    if ([@"Comments" isEqualToString:[tableArray objectAtIndex:section]]) {
        return 1 + [restaurant.comments count];
    } else if ([@"Tags" isEqualToString:[tableArray objectAtIndex:section]]) {
        if(tagsBeingLoaded) {
            return 2;
        } else {
            return 7;
        }
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cells...
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
        RestaurantHeaderCell *restaurantHeaderCell = (RestaurantHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantHeaderCell"];
		if (restaurantHeaderCell == nil) {
		    restaurantHeaderCell = [[[RestaurantHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantHeaderCell" andRVC:self] autorelease];
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
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Menu"]) {
        RestaurantMenuCell *restaurantMenuCell = (RestaurantMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantMenuCell"];
		if (restaurantMenuCell == nil) {
		    restaurantMenuCell = [[[RestaurantMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantMenuCell" andParentView:self] autorelease];
		}          
		return restaurantMenuCell;

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
        if (indexPath.row == 0) {
            QuickReviewHeaderCell *restaurantTagsCell = (QuickReviewHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantHeaderTagsCell"];
            if (restaurantTagsCell == nil) {
                restaurantTagsCell = [[[QuickReviewHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantHeaderTagsCell" andContext:@"restaurant"] autorelease];
            }          
            [restaurantTagsCell loadRestaurant:restaurant];
            return restaurantTagsCell;

        } else if (indexPath.row == 6) {
            MoreTagsCell *moreTagsCell = (MoreTagsCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreTagsCell"];
            if(moreTagsCell == nil) {
                moreTagsCell = [[[MoreTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreTagsCell"] autorelease];
            }
            return moreTagsCell;
            
        } else {
            if (tagsBeingLoaded) {
                LoadingTagCell *loadingCell = (LoadingTagCell *)[tableView dequeueReusableCellWithIdentifier:@"TagsLoadingCell"];
                if (loadingCell == nil) {
                    loadingCell = [[[LoadingTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TagsLoadingCell"] autorelease];
                }          

                return loadingCell;
            
            } else {
                TagCell *tagCell = (TagCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantTagsCell"];
                if(tagCell == nil){
                    tagCell = [[[TagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantTagsCell" andDelegate:self] autorelease];
                }
                [tagCell loadTag:[restaurant.tags objectAtIndex:indexPath.row - 1]];
                return tagCell;

            }
        }
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"WebsiteLink"]) {
        RestaurantWebsiteCell *restaurantWebsiteCell = (RestaurantWebsiteCell *)[tableView dequeueReusableCellWithIdentifier:@"RestaurantWebsiteCell"];
		if (restaurantWebsiteCell == nil) {
		    restaurantWebsiteCell = [[[RestaurantWebsiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RestaurantWebsiteCell" andRestaruantController:self] autorelease];
		}          
		return restaurantWebsiteCell;

    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Comments"]) {
        if(indexPath.row == 0) {
            CommentsHeaderCell *commentsHeaderCell = (CommentsHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentsHeaderCell"];
            if (commentsHeaderCell == nil) {
                commentsHeaderCell = [[[CommentsHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentsHeaderCell"] autorelease];
            }          
            return commentsHeaderCell;
        } else if ([restaurant.comments count] > 0) {
            CommentCell *commentCell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
            if (commentCell == nil) {
                commentCell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentCell"] autorelease];
            }
            [commentCell loadComment:[restaurant.comments objectAtIndex:(indexPath.row - 1)]];
            return commentCell;
        } else {
            return nil;
        }
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"AdditionalInformation"]) {
        RestaurantAdditionalInformationCell *cell = (RestaurantAdditionalInformationCell *)[tableView dequeueReusableCellWithIdentifier:@"AdditionalInformationCell"];
        if(cell==nil){
            cell =[[[RestaurantAdditionalInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AdditionalInformationCell"] autorelease];
        }
        [cell loadRestaurant:restaurant];
        return cell;
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
        height = 110;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
        height = 45;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Phone"]) {
        height = 45;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Menu"]) {
        height = 44;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"WebsiteLink"]) {
        height = 44;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"AdditionalInformation"]) {
        height = 115;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        if (indexPath.row == 0) {
            height = 60;
        } else {
            height = 44;
        }
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Comments"]) {
        if([restaurant.comments count] > 0 && indexPath.row > 0) {
            Comment * comment = (Comment *)[restaurant.comments objectAtIndex:(indexPath.row - 1)];
            height = [StringSizeUtility cellHeightForString:comment.text withFrame:CGRectMake(10, 30, 310, 20) andBottomPadding:10.0];
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
        
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
    
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Menu"]) {
    
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        if(!tagsBeingLoaded) {
            if(indexPath.row == 6) {
                TagViewController *tvc = [[TagViewController alloc] initWithNibName:@"TagViewController" bundle:nil andTaggedObject:restaurant];
                [self.navigationController pushViewController:tvc animated:YES];
                [tvc release];
            } else if(indexPath.row > 0){
                TagCell *tc = (TagCell *)[tableView cellForRowAtIndexPath:indexPath];
                if (tc.tag.isUserTag) {
                    [tc.service deleteTagFromRestaurant:restaurant withTag:tc.tag.name];
                } else {
                    [tc.service tagRestaurant:restaurant withTag:tc.tag.name];
                }
            }
        }
    }
}

-(void)callButtonPressed:(id)sender
{
    NSString *phoneNumber = [NSString stringWithString:restaurant.phone];
//    NSString *phoneNumber = [restaurant.phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
//    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
//    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSMutableString *strippedPhoneNumber;
    for (int i=0; i<[phoneNumber length]; i++) {
        if (isdigit([phoneNumber characterAtIndex:i])) {
            [strippedPhoneNumber appendFormat:@"%c",[phoneNumber characterAtIndex:i]];
        }
    }
    
    if (([strippedPhoneNumber length] == 10) || ([strippedPhoneNumber length] == 7)) {    
        NSString *phoneNumberString = [NSString stringWithFormat:@"tel://%@", strippedPhoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberString]];
    }
}

-(void)mapItButtonPressed:(id)sender
{
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    NSRange range1 = NSMakeRange(0, [restaurant.address_2 length]);
//    restaurant.address_2 = [restaurant.address_2 stringByReplacingOccurrencesOfString:@"<null>" withString:@"" options:NULL range:range1];
    
    NSString *addressString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@", restaurant.address_1, restaurant.address_2, restaurant.city_town, restaurant.state_province, restaurant.postal_code, restaurant.country];
    addressString = [addressString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *requestString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%@&z=15", appDelegate.currentLocation.coordinate.latitude, appDelegate.currentLocation.coordinate.longitude, addressString];
    NSRange range = NSMakeRange(0, [requestString length]);
    requestString = [requestString stringByReplacingOccurrencesOfString:@"<null>" withString:@"" options:NULL range:range];
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:requestString]];	

}
-(void)photoButtonPressed:(id)sender
{
    [takePhoto loadPhotoForRestaurant:restaurant withView:self];
}
-(void)menuButtonPressed:(id)sender
{
    [self loadMenu];
}
-(void)bookmarkButtonPressed:(id)sender
{
    BookmarkService *rbs = [[BookmarkService alloc]initWithDelegate:self];
    if (restaurant.bookmark) {
        [rbs deleteBookmarkForRestaurant:restaurant];
    } else {
        [rbs bookmarkRestaurant:restaurant];
    }
}

-(void)websiteButtonPressed:(id)sender {
    if(![restaurant.website_url isKindOfClass:[NSNull class]]){
        WebViewController *wvc = [[WebViewController alloc] init];
        wvc.urlAddress = [restaurant.website_url retain];
        [wvc setTitle:restaurant.name];
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
        restaurant.bookmark = !restaurant.bookmark;
        NSString *messageString;
        if (restaurant.bookmark) {
            messageString = [NSString stringWithFormat:@"You have added this restaurant to your favorites."];
        } else {
            messageString = [NSString stringWithFormat:@"You have removed this restaurant from your favorites."];
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success!" message:messageString delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                
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
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    RatingPopupViewController *rpvc = [[RatingPopupViewController alloc]initWithCurrentRating:restaurant.rating.user_rating];
    rpvc.delegate = self;
    rpvc.view.alpha = 0.0;
    [appDelegate.tabBarController.view addSubview:rpvc.view];
    [rpvc animateIn];
}

-(void)startRatingServiceWithRating:(float)rating andComments:(NSString *)comments
{
    RatingService *rrs = [[RatingService alloc] initWithDelegate:self];
    [rrs rateRestaurant:restaurant withRating:rating];
    
    if ([comments length] > 0) {
        CommentService *cs = [[CommentService alloc]initWithDelegate:self];
        [cs commentOnRestaurant:restaurant withComment:comments];
    }
}

-(void) doneCommenting:(NSDictionary *) status {
    NSLog(@"done commenting: %@", status);
    Comment *comment = [[Comment alloc] initWithDictionary:status];
    [restaurant.comments addObject:comment];
    [comment release];
    [self buildTableArray];
    [self.tableView reloadData];
}

-(void) tagsRetrieved:(NSMutableArray *)tags {
    [restaurant addAllTags:tags];
    tagsBeingLoaded = false;
    [self.tableView reloadData];
}

-(void) newImageLoaded:(NSDictionary *)dict_passed {
    [restaurant.pictures addObject:dict_passed];
    [self.tableView reloadData];
}

-(void) doneTagging:(NSMutableArray *)tagsFromUser {
    [restaurant updateUserTags:tagsFromUser];
    [self.tableView reloadData];
}

@end
