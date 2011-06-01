//
//  PhotoViewer.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "PhotoViewer.h"
#import "IGUIScrollViewImage.h"
#import "UIImageView+WebCache.h"
#import "iRestaurantAppDelegate.h"
#import "UIDeviceHardware.h"

@implementation PhotoViewer

@synthesize svimage, navItem, dishNameLabel, commentLabel, arrayOfPhotos;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setupScrollView:(NSArray *)arrayOfPhotos_passed {
    arrayOfPhotos = [arrayOfPhotos_passed retain];
    NSLog(@"array of photos: %@", arrayOfPhotos);
    //self.view.backgroundColor = [UIColor blackColor];
    UIImage *noImage = [UIImage imageNamed:@"no-image-300.png"];
    NSMutableArray *imageViewArray = [[NSMutableArray alloc]init];
    NSMutableArray *dishNameLabelArray = [[NSMutableArray alloc]init];
    NSMutableArray *commentLabelArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i < [arrayOfPhotos count]; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        UIDeviceHardware *h=[[UIDeviceHardware alloc] init];
        if ([[h platformString] isEqualToString:@"iPhone 4"]) {
            NSLog(@"we have an iPhone 4");
            
            [imageView setImageWithURL:[NSURL URLWithString:[[arrayOfPhotos objectAtIndex:i] objectForKey:@"640px"]] placeholderImage:noImage];
        } else {
            [imageView setImageWithURL:[NSURL URLWithString:[[arrayOfPhotos objectAtIndex:i] objectForKey:@"300px"]] placeholderImage:noImage];
        }
        
        
        [imageViewArray addObject:imageView];
        [dishNameLabelArray addObject:[[arrayOfPhotos objectAtIndex:i] objectForKey:@"menu_item_name"]];
        
        NSArray *commentsArrayForPic = [[arrayOfPhotos objectAtIndex:i] objectForKey:@"comments"];
        NSLog(@"comments array: %@", commentsArrayForPic);
        
        if ([commentsArrayForPic count] > 0) {
            [commentLabelArray addObject:[commentsArrayForPic objectAtIndex:0]];
        } else {
            // add blank string
            [commentLabelArray addObject:@""];
        }
    }
    
    UIView *viewForScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 320)];
    
    svimage = [[IGUIScrollViewImage alloc] init];  
    svimage.delegate = self;
    [svimage setBackGroudColor:[UIColor clearColor]];
    [svimage setContentArray:imageViewArray]; 
    [svimage setWidth:320 andHeight:320];
    [svimage enablePageControlOnBottom];  
    [viewForScrollView addSubview:[svimage getWithPosition:0]]; 
    svimage.scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:viewForScrollView];
    [svimage setDishNameLabelArray:dishNameLabelArray andCommentLabelArray:commentLabelArray];
    [viewForScrollView release];
}

-(void) setImageLabelsDishName:(NSString *)dishNameString andComment:(NSString *)commentString {
    if ((dishNameString != NULL) && (![dishNameString isKindOfClass:[NSNull class]])) {
        dishNameLabel.text = [dishNameString retain];
    } else {
        dishNameLabel.text = @"";
    }
    if ((commentString != NULL) && (![commentString isKindOfClass:[NSNull class]])) {
        commentLabel.text = [commentString retain];
    } else {
        commentLabel.text = @"";
    }
}

-(IBAction) reportAbuseButtonPressed:(id)sender {
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    UIActionSheet *ac = [[UIActionSheet alloc]initWithTitle:@"Report Abuse" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Flag Picture For Review" otherButtonTitles:nil];
    [ac showInView:self.view];
//    [ac showFromTabBar:appDelegate.tabBarController.tabBar];
    [ac release];
}         
    
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"currentpage: %i", svimage.pageControl.currentPage);
    NSLog(@"index: %i", buttonIndex);
    if (buttonIndex == 0) [self launchEmailFeedbackForPictureAtIndex:svimage.pageControl.currentPage];
}

-(void) launchEmailFeedbackForPictureAtIndex:(int)index {
    NSDictionary *currentPhoto = [arrayOfPhotos objectAtIndex:index];
    NSString *currentImageID = [currentPhoto objectForKey:@"id"];
    NSString *menuItemName = [currentPhoto objectForKey:@"menu_item_name"];
    NSString *restaurantName = [currentPhoto objectForKey:@"restaurant_name"];
    NSString *imageURL = [currentPhoto objectForKey:@"300px"];
    
    
	@try {
		MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		picker.mailComposeDelegate = self; // &lt;- very important step if you want feedbacks on what the user did with your email sheet
		
		[picker setSubject:[NSString stringWithFormat:@"TasteBuddy feedback for image on %@", menuItemName]];
		NSString *emailBody = [NSString stringWithFormat:@"Enter your message... \n\n Please review this image on %@. \n\n URL:\n %@ \n\n Image ID:\n %@ \n\n", restaurantName, imageURL, currentImageID];	
		[picker setMessageBody:emailBody isHTML:NO];
		NSArray *toRecipients = [[NSArray alloc]initWithObjects:@"feedback@tastebuddy.mobi", nil];
		[picker setToRecipients:toRecipients];
        picker.navigationBar.tintColor = [UIColor colorWithRed:240.0/255.0 green:189.0/255.0 blue:34.0/255.0 alpha:1.0];
		[self presentModalViewController:picker animated:YES];
		[picker release];
	}
	@catch (NSException * e) {
		// add error handling
	}
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{ 
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
			
		default:
		{
			// add error handling
        }
            break;
	}
	[self dismissModalViewControllerAnimated:YES];
}




-(IBAction) closeButtonPressed {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
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
    // Do any additional setup after loading the view from its nib.
}

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
