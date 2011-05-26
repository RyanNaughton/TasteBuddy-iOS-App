//
//  ProfilePhotoCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "ProfilePhotoCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "PhotoViewer.h"
#import "iRestaurantAppDelegate.h"
#import "RestaurantService.h"
#import "RestaurantViewController.h"
#import "ProfileTableViewController.h"

@implementation ProfilePhotoCell
@synthesize imageView, restaurantLabel, pictureCountLabel, restaurantDictionary, ptvc;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(10, 10, 65, 65);
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.borderWidth = 1;
        [self.contentView addSubview:imageView];
        
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageButton addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.frame = CGRectMake(10, 10, 65, 65);
        [self.contentView addSubview:imageButton];
        
        restaurantLabel = [[UILabel alloc]init];
        restaurantLabel.frame = CGRectMake(85, 10, 250, 25);
        restaurantLabel.textColor = [UIColor blackColor];
        restaurantLabel.backgroundColor = [UIColor clearColor];
        restaurantLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:restaurantLabel];
        
        UIButton *restaurantButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [restaurantButton addTarget:self action:@selector(restaurantButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        restaurantButton.frame = CGRectMake(85, 10, 250, 25);
        [self.contentView addSubview:restaurantButton];
        
        pictureCountLabel = [[UILabel alloc]init];
        pictureCountLabel.frame = CGRectMake(85, 35, 250, 25);
        pictureCountLabel.textColor = [UIColor blackColor];
        pictureCountLabel.backgroundColor = [UIColor clearColor];
        pictureCountLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:pictureCountLabel];


    }
    return self;
}

-(void)setVariablesWithDictionary:(NSDictionary *)restaurantDictionary_passed {
    restaurantDictionary = restaurantDictionary_passed;
    
    NSLog(@"restaurantDict: %@", restaurantDictionary);
    
    NSArray *photoArray = [restaurantDictionary objectForKey:@"array"];
    NSString *restaurantName = [restaurantDictionary objectForKey:@"name"];
    NSDictionary *currentPhoto = [photoArray objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:[currentPhoto objectForKey:@"300px"]];
    [imageView setImageWithURL:url]; 
    restaurantLabel.text = [restaurantName retain]; //Retain may not be needed
    pictureCountLabel.text = [NSString stringWithFormat:@"%i Pictures", [photoArray count]];
}

-(void)imageButtonPressed:(id)sender {
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSArray *arrayOfPhotos = [restaurantDictionary objectForKey:@"array"];
    NSString *restaurantName = [restaurantDictionary objectForKey:@"name"];
    
    NSMutableArray *arrayOfURLStrings = [[NSMutableArray alloc]init];
    for (NSDictionary *photoDict in arrayOfPhotos) {
        [arrayOfURLStrings addObject:[photoDict objectForKey:@"300px"]];
    }
    
    PhotoViewer *photoViewer = [[PhotoViewer alloc]init];            
    [photoViewer setupScrollView:arrayOfPhotos];
    photoViewer.navItem.title = [NSString stringWithFormat:@"%@", restaurantName];
    photoViewer.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [appDelegate.tabBarController presentModalViewController:photoViewer animated:YES];
    [photoViewer release];
}

-(void)restaurantButtonPressed:(id)sender {
    NSString *restaurantID = [[[restaurantDictionary objectForKey:@"array"] objectAtIndex:0] objectForKey:@"restaurant_id"];
    RestaurantService *rs = [[RestaurantService alloc]initWithDelegate:self];
    [rs findRestaurantById:restaurantID];
}

-(void)restaurantRetrieved:(Restaurant *) restuarant 
{
    RestaurantViewController *rvc = [[RestaurantViewController alloc]initWithRestaurant:restuarant];
    [ptvc.navigationController pushViewController:rvc animated:YES];
    [rvc release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [imageView release];
    [restaurantLabel release];
    [pictureCountLabel release];
    [super dealloc];
}

@end
