//
//  DishImageCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 6/8/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishImageCell.h"
#import "IGUIScrollViewImage.h"
#import <QuartzCore/QuartzCore.h>
#import "MenuItem.h"
#import "Restaurant.h"
#import "UIDeviceHardware.h"
#import "iRestaurantAppDelegate.h"
#import "PhotoViewer.h"
#import "UIImageView+WebCache.h"

@implementation DishImageCell

@synthesize svimage, viewForScrollView, singleImageView, menu_item, restaurant;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        singleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 300)];
        singleImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        singleImageView.layer.borderWidth = 1;
        [self.contentView addSubview:singleImageView];
        
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageButton addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.frame = CGRectMake(10, 10, 300, 300);
        [self.contentView addSubview:imageButton];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadMenuItem:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant_passed
{
    menu_item = menu_item_passed;
    restaurant = restaurant_passed;

    NSMutableArray *arrayOfURLStrings = [[NSMutableArray alloc]init];
    for (NSDictionary *pictDict in menu_item.pictures) {
        
        UIDeviceHardware *h=[[UIDeviceHardware alloc] init];
        if ([[h platformString] isEqualToString:@"iPhone 4"] || [[h platformString] isEqualToString:@"iPod Touch 4G"]) {
            NSLog(@"we have an iPhone 4");
            [arrayOfURLStrings addObject:[pictDict objectForKey:@"640px"]];
        } else {
            [arrayOfURLStrings addObject:[pictDict objectForKey:@"300px"]];
        }
    }
    
    NSLog(@"arrayOfURLStrings: %@", arrayOfURLStrings);
    
    UIImage *noImage = [UIImage imageNamed:@"no-image-300.png"];
    NSMutableArray *imageViewArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i < [arrayOfURLStrings count]; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImageWithURL:[NSURL URLWithString:[arrayOfURLStrings objectAtIndex:i]] placeholderImage:noImage];
        [imageViewArray addObject:imageView];
    }
    
    if ([arrayOfURLStrings count] == 0) {
        singleImageView.image = noImage;        
    } else {
        [singleImageView setImageWithURL:[NSURL URLWithString:[arrayOfURLStrings objectAtIndex:0]] placeholderImage:noImage];
    }
}

-(void) imageButtonPressed:(id)sender {
    if ([menu_item.pictures count] > 0) {
        iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
        PhotoViewer *photoViewer = [[PhotoViewer alloc]initWithNibName:@"PhotoViewer" bundle:nil];            
        [photoViewer setupScrollView:menu_item.pictures];
        photoViewer.navItem.title = restaurant.name; //[NSString stringWithFormat:@"%@", menu_item.name];
        photoViewer.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [appDelegate.tabBarController presentModalViewController:photoViewer animated:YES];
        [photoViewer release];
    }
}


@end
