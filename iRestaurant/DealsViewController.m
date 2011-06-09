//
//  DealsViewController.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/31/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DealsViewController.h"
#import "DealsService.h"
#import "DealsCell.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "iRestaurantAppDelegate.h"

@implementation DealsViewController
@synthesize ds, dealsArray, noImage;

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
    [super dealloc];
}

-(void) dealDataReturned:(NSDictionary *)dict
{
    dealsArray = [[[dict objectForKey:@"response"] objectForKey:@"deals"]retain];
    [self.tableView reloadData];
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
    
    [self setTitle:@"Deals"];
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dealsLogo.png"]];
    appNameImageView.frame = CGRectMake(0, -3, 155, 44);
    appNameImageView.contentMode = UIViewContentModeRight;
    self.navigationItem.titleView = appNameImageView;
    
    noImage = [UIImage imageNamed:@"no-image-80.png"];
    ds = [[DealsService alloc]initWithDelegate:self];
    [ds getDeals];

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

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"";
//}
//


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([dealsArray count] > 0) {
        return [dealsArray count];
    } else { 
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([dealsArray count] > 0) {
        static NSString *CellIdentifier = @"Cell";
        
        DealsCell *cell = (DealsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[DealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        NSURL *dealImageURL = [NSURL URLWithString:[[[dealsArray objectAtIndex:indexPath.row] objectForKey:@"images"] objectForKey:@"image_small"]];
        cell.dealLabel.text = [[dealsArray objectAtIndex:indexPath.row] objectForKey:@"yipit_title"];
        [cell setDistanceLabelWithDictionary:[dealsArray objectAtIndex:indexPath.row]];
        [cell setDurationLabelWithDictionary:[dealsArray objectAtIndex:indexPath.row]];
        [cell.dealImageView setImageWithURL:dealImageURL placeholderImage:noImage];
        cell.accessoryView = nil;
        return cell;
    } else { 
        static NSString *CellIdentifier = @"LoadingCell";
        
        UITableViewCell *loadingCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (loadingCell == nil) {
            loadingCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        loadingCell.textLabel.text = @"Loading...";
        UIActivityIndicatorView *ac = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [ac startAnimating];
        loadingCell.accessoryView = ac;
        loadingCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return loadingCell;
    }
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
    NSString *urlString = [[dealsArray objectAtIndex:indexPath.row] objectForKey:@"yipit_url"];
    NSString *headerString = [[[dealsArray objectAtIndex:indexPath.row]objectForKey:@"business"]objectForKey:@"name"];
    
    if(![urlString isKindOfClass:[NSNull class]]){
        WebViewController *wvc = [[WebViewController alloc] init];
        wvc.urlAddress = [urlString retain];
        [wvc setTitle:headerString];
        [self.navigationController pushViewController:wvc animated:YES];
        [wvc release];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unknown Website" message:@"We're sorry, but we could not load this deal" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

}

@end
