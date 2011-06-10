//
//  ProfileHeadCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "ProfileHeadCell.h"
#import "iRestaurantAppDelegate.h"

@implementation ProfileHeadCell
@synthesize nameLabel, reviewsLabel, picturesLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.backgroundColor = [UIColor clearColor];
                
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(10, 9, 250, 25);
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:nameLabel];
        
        UIButton *feedbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [feedbackButton setImage:[UIImage imageNamed:@"09-chat-2.png"] forState:UIControlStateNormal];
        [feedbackButton addTarget:self action:@selector(feedbackButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        feedbackButton.frame = CGRectMake(290, 13, 20, 20);
        [self.contentView addSubview:feedbackButton];

        UIImageView *reviewImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"162-receipt.png"]];
        reviewImage.frame = CGRectMake(10, 43, 18, 18);;
        reviewImage.alpha = 0.8;
        [self.contentView addSubview:reviewImage];

        UILabel *youveSubmitted = [[UILabel alloc]init];
        youveSubmitted.frame = CGRectMake(35, 40, 130, 25);
        youveSubmitted.textColor = [UIColor blackColor];
        youveSubmitted.backgroundColor = [UIColor clearColor];
        youveSubmitted.font = [UIFont systemFontOfSize:14];
        youveSubmitted.text = @"You've submitted";
        [self.contentView addSubview:youveSubmitted];
        [youveSubmitted release];

        reviewsLabel = [[UILabel alloc]init];
        reviewsLabel.frame = CGRectMake(150, 40, 250, 25);
        reviewsLabel.textColor = [UIColor blackColor];
        reviewsLabel.backgroundColor = [UIColor clearColor];
        reviewsLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:reviewsLabel];
        
        UIImageView *picturesImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"42-photos.png"]];
        picturesImage.frame = CGRectMake(10, 73, 18, 18);
        picturesImage.alpha = 0.8;
        [self.contentView addSubview:picturesImage];
        
        UILabel *youveTaken = [[UILabel alloc]init];
        youveTaken.frame = CGRectMake(35, 70, 100, 25);
        youveTaken.textColor = [UIColor blackColor];
        youveTaken.backgroundColor = [UIColor clearColor];
        youveTaken.font = [UIFont systemFontOfSize:14];
        youveTaken.text = @"You've taken";
        [self.contentView addSubview:youveTaken];
        [youveTaken release];
        
        picturesLabel = [[UILabel alloc]init];
        picturesLabel.frame = CGRectMake(125, 70, 250, 25);
        picturesLabel.textColor = [UIColor blackColor];
        picturesLabel.backgroundColor = [UIColor clearColor];
        picturesLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:picturesLabel];
    }
    return self;
}

-(void)setUserInfoWithName:(NSString *)name andReviews:(int)reviewsCount andPictures:(int)picturesCount {
    nameLabel.text = name;
    reviewsLabel.text = [NSString stringWithFormat:@"%i ratings", reviewsCount];
    picturesLabel.text = [NSString stringWithFormat:@"%i pictures", picturesCount];
}

-(void) feedbackButtonPressed 
{
    
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    UIActionSheet *ac = [[UIActionSheet alloc]initWithTitle:@"User Feedback" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Send Feedback", nil];
    [ac showFromTabBar:appDelegate.tabBarController.tabBar];
    [ac release];
}         

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) [self launchEmailFeedback];
}

-(void) launchEmailFeedback {    
	@try {
		iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		picker.mailComposeDelegate = self; // &lt;- very important step if you want feedbacks on what the user did with your email sheet
		
		[picker setSubject:[NSString stringWithFormat:@"TasteBuddy feedback from %@", nameLabel.text]];
		NSString *emailBody = [NSString stringWithFormat:@"Enter your message... \n\n"];	
		[picker setMessageBody:emailBody isHTML:NO];
		NSArray *toRecipients = [[NSArray alloc]initWithObjects:@"feedback@tastebuddy.mobi", nil];
		[picker setToRecipients:toRecipients];
        picker.navigationBar.tintColor = [UIColor colorWithRed:240.0/255.0 green:189.0/255.0 blue:34.0/255.0 alpha:1.0];
		[appDelegate.tabBarController presentModalViewController:picker animated:YES];
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
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate.tabBarController dismissModalViewControllerAnimated:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    [nameLabel release];
    [reviewsLabel release];
    [picturesLabel release];
    [super dealloc];
}

@end
