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
#import "RestaurantService.h"
#import "RestaurantViewController.h"
#import "TagViewController.h"
#import "CommentService.h"
#import "Festival.h"
#import "UIImageView+WebCache.h"


// CELLS
#import "DishHeaderCell.h"
#import "DishButtonsCell.h"
#import "RestaurantAddressCell.h"
#import "RestaurantPhoneCell.h"
#import "QuickReviewHeaderCell.h"
#import "CommentsHeaderCell.h"
#import "CommentCell.h"
#import "MoreTagsCell.h"
#import "StringSizeUtility.h"
#import "LoadingTagCell.h"
#import "TagCell.h"
#import "Tag.h"
#import "DishRestaurantCell.h"
#import "DishImageCell.h"
#import "DescriptionHeaderCell.h"
#import "DescriptionCell.h"

@implementation DishViewController

@synthesize restaurant, menu_item, tableArray, takePhoto, tagService, tagsBeingLoaded, festival;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithMenuItem:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant_passed andFestival:(Festival *) festival_passed
{    
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        self.tableView.backgroundColor = [UIColor whiteColor];
        menu_item = [menu_item_passed retain];
        restaurant = [restaurant_passed retain];
        if(festival_passed) {
            festival = [festival_passed retain];
        }
        NSLog(@"is favorite? %i", menu_item.bookmark);
        
        tableArray = [[NSMutableArray alloc]init];
        [self buildTableArray];
    
        tagsBeingLoaded = true;
        tagService =[[TagService alloc] initWithDelegate:self];
        [tagService getTags];
    }
    return self;
}

-(void) buildTableArray {
    
    [tableArray removeAllObjects];
    
    [tableArray addObject:@"Restaurant"];
    [tableArray addObject:@"Header"];
    
    if ([menu_item.pictures count] > 0) {
        [tableArray addObject:@"Image"];
    }
    
    [tableArray addObject:@"Buttons"];
    if(menu_item.description == NULL || ![menu_item.description isKindOfClass:[NSNull class]]){
        [tableArray addObject:@"Description"];
    }
    //[tableArray addObject:@"Tags"]; 
    
    if ([menu_item.comments count] > 0) {
        [tableArray addObject:@"Comments"];
    }

}

- (void)dealloc
{
    [festival release];
    [tagService release];
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
    } else if ([@"Tags" isEqualToString:[tableArray objectAtIndex:section]]) {
        if(tagsBeingLoaded) {
            return 2;
        } else {
            return 7;
        }
    }else if ([@"Description" isEqualToString:[tableArray objectAtIndex:section]]) {
        return 2;
    } else {
        return 1;        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Restaurant"]) {
        DishRestaurantCell *dishRestaurantCell = (DishRestaurantCell *)[tableView dequeueReusableCellWithIdentifier:@"DishRestaurantCell"];
		if (dishRestaurantCell == nil) {
		    dishRestaurantCell = [[[DishRestaurantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishRestaurantCell"] autorelease];
            dishRestaurantCell.textLabel.text = restaurant.name;
        }          
		return dishRestaurantCell;
    
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
        DishHeaderCell *dishHeaderCell = (DishHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"DishHeaderCell"];
		if (dishHeaderCell == nil) {
		    dishHeaderCell = [[[DishHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishHeaderCell" andDishViewController:self] autorelease];
        }          
        [dishHeaderCell loadMenuItem:menu_item andRestaurant:restaurant];
		return dishHeaderCell;

    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Image"]) {
        DishImageCell *dishImageCell = (DishImageCell *)[tableView dequeueReusableCellWithIdentifier:@"DishImageCell"];
		if (dishImageCell == nil) {
		    dishImageCell = [[[DishImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishImageCell"] autorelease];
        }          
        [dishImageCell loadMenuItem:menu_item andRestaurant:restaurant];
		return dishImageCell;
        
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Buttons"]) {
        DishButtonsCell *dishButtonsCell = (DishButtonsCell *)[tableView dequeueReusableCellWithIdentifier:@"DishButtonsCell"];
		if (dishButtonsCell == nil) {
		    dishButtonsCell = [[[DishButtonsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishButtonsCell" andParentView:self] autorelease];
		}          
        //[dishButtonsCell loadRestaurant:restaurant];
		return dishButtonsCell;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Description"]) {
        if (indexPath.row == 0) {
            DescriptionHeaderCell *descriptionHeaderCell = (DescriptionHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"DescriptionHeaderCell"];
            if(descriptionHeaderCell == nil) {
               descriptionHeaderCell = [[[DescriptionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DescriptionHeaderCell"] autorelease]; 
            }
            return descriptionHeaderCell;
        } else {
            DescriptionCell * descriptionCell = (DescriptionCell* )[tableView dequeueReusableCellWithIdentifier:@"DescriptionCell"];
            if(descriptionCell == nil){
                descriptionCell = [[[DescriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DescriptionCell"] autorelease]; 
 
            }
            [descriptionCell loadDescription:menu_item.description];
            return descriptionCell;

        }
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        if (indexPath.row == 0) {
            QuickReviewHeaderCell *restaurantTagsCell = (QuickReviewHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"DishHeaderTagsCell"];
            if (restaurantTagsCell == nil) {
                restaurantTagsCell = [[[QuickReviewHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishHeaderTagsCell" andContext:@"menu_item"] autorelease];
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
                TagCell *tagCell = (TagCell *)[tableView dequeueReusableCellWithIdentifier:@"DishTagsCell"];
                if(tagCell == nil){
                    tagCell = [[[TagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DishTagsCell" andDelegate:self] autorelease];
                }
                [tagCell loadTag:[menu_item.tags objectAtIndex:indexPath.row - 1]];
                return tagCell;
                
            }
        }
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
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Restaurant"]) {
        height = 40;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Header"]) {
        
        CGSize maximumLabelSize = CGSizeMake(210,9999);
        CGSize expectedLabelSize = [menu_item.name sizeWithFont:[UIFont boldSystemFontOfSize:17] 
                                              constrainedToSize:maximumLabelSize 
                                                  lineBreakMode:UILineBreakModeWordWrap];
        int newHeight = expectedLabelSize.height + 45;
        if (![menu_item.foreign_name isKindOfClass:[NSNull class]]) {
            newHeight += 15;
        }
        NSLog(@"new height: %i", newHeight);
        height = newHeight;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Image"]) {
        height = 320;
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Buttons"]) {
        height = 110.0;
    }  else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        if (indexPath.row == 0) {
            height = 60;
        } else {
            height = 44;
        }
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Description"]) {
        if(indexPath.row > 0) {
            height = [StringSizeUtility cellHeightForString:menu_item.description withFrame:CGRectMake(10, 0, 310, 20) andBottomPadding:10.0];
        } else {
            height = 50;
        }
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Comments"]) {
        if([menu_item.comments count] > 0 && indexPath.row > 0) {
            Comment * comment = (Comment *)[menu_item.comments objectAtIndex:(indexPath.row - 1)];
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
    
    if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Restaurant"]) {
        [self restaurantButtonPressed:nil];
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Address"]) {
    
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Phone"]) {
    
    } else if ([[tableArray objectAtIndex:indexPath.section] isEqualToString:@"Tags"]) {
        if(!tagsBeingLoaded) {
            if(indexPath.row == 6) {
                TagViewController *tvc = [[TagViewController alloc] initWithNibName:@"TagViewController" bundle:nil andTaggedObject:menu_item];
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
    NSString *phoneNumber = [restaurant.phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];    
    NSString *phoneNumberString = [NSString stringWithFormat:@"tel://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberString]];
}

-(void)mapItButtonPressed:(id)sender
{
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *addressString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@", restaurant.address_1, restaurant.address_2, restaurant.city_town, restaurant.state_province, restaurant.postal_code, restaurant.country];
    addressString = [addressString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *requestString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%@&z=15", appDelegate.currentLocation.coordinate.latitude, appDelegate.currentLocation.coordinate.longitude, addressString];
    NSRange range = NSMakeRange(0, [requestString length]);
    requestString = [requestString stringByReplacingOccurrencesOfString:@"<null>" withString:@"" options:NULL range:range];
    UIApplication *app = [UIApplication sharedApplication];
    NSLog(@"map it: %@", requestString);
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
    NSLog(@"bookmark?: %i", menu_item.bookmark);
    if (menu_item.bookmark) {
        [bs deleteBookmarkForMenuItem:menu_item];
    } else {
        [bs bookmarkMenuItem:menu_item]; 
    }
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
    [rrs rateMenuItem:menu_item withRating:rating];
    
    if ([comments length] > 0) {
        CommentService *cs = [[CommentService alloc]initWithDelegate:self];
        [cs commentOnMenuItem:menu_item withComment:comments];
    }
}

-(void) doneCommenting:(NSDictionary *) status {
    NSLog(@"done commenting: %@", status);
    
    Comment *comment = [[Comment alloc] initWithDictionary:status];
    [menu_item.comments addObject:comment];
    [comment release];
    [self buildTableArray];
    [self.tableView reloadData];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
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
//    [self.tableView reloadData];
    [self.tableView reloadData];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
}

-(void) doneBookmarking:(NSDictionary *) status {
    
    // toggle bookmark
    menu_item.bookmark = !menu_item.bookmark;
    
    if ([[status objectForKey:@"status"] isEqualToString:@"success"]) {
        NSString *messageString;
        if (menu_item.bookmark) {
            messageString = [NSString stringWithFormat:@"You have added this menu item to your favorites."];
        } else {
            messageString = [NSString stringWithFormat:@"You have removed this menu item from your favorites."];
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success!" message:messageString delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else  {
        NSString *messageString = [NSString stringWithFormat:@"We're sorry, but there was an error."];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:messageString delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
}

-(void) newImageLoaded:(NSDictionary *)dict_passed {
    NSLog(@"it made it! %@", dict_passed);
    [menu_item.pictures addObject:dict_passed];
    [self buildTableArray];
    [self.tableView reloadData];
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//    DishHeaderCell *dhc = (DishHeaderCell *)[self.tableView cellForRowAtIndexPath:indexPath]; 
//    [dhc.viewForScrollView removeFromSuperview];
//    [dhc loadMenuItem:menu_item andRestaurant:restaurant];
    //[self.tableView reloadData];
}

-(void)restaurantButtonPressed:(id)sender {

    RestaurantViewController *rvc = [[RestaurantViewController alloc]initWithRestaurant:restaurant andFestival:festival];
    [self.navigationController pushViewController:rvc animated:YES];
    [rvc release];
    
}

-(void) doneTagging:(NSMutableArray *)tagsFromUser {
    [menu_item updateUserTags:tagsFromUser];
    [self.tableView reloadData];
}
-(void) tagsRetrieved:(NSMutableArray *)tags {
    [menu_item addAllTags:tags];
    tagsBeingLoaded = false;
    [self.tableView reloadData];
}

@end
