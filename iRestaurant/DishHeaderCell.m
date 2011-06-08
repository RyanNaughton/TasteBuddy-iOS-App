//
//  DishHeaderCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/15/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishHeaderCell.h"
#import "MenuItem.h"
#import "UIImageView+WebCache.h"
#import "RatingView.h"
#import "Restaurant.h"
#import "RestaurantViewController.h"
#import "RestaurantService.h"
#import "DishViewController.h"
#import "PhotoViewer.h"
#import "iRestaurantAppDelegate.h"

#import "IGUIScrollViewImage.h"
#import <QuartzCore/QuartzCore.h>
#import "UILabelUnderlined.h"
#import "UIDeviceHardware.h"

@implementation DishHeaderCell

@synthesize name, price, ratingView, restaurantName, svimage, viewForScrollView, singleImageView, dvc, menu_item, bookmarkButton, photoButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDishViewController:(DishViewController *)dvc_passed
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        dvc = [dvc_passed retain];
        
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(10, 7, 240, 20);
        name.adjustsFontSizeToFitWidth = TRUE;
        name.numberOfLines = 5;
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:17];
        name.shadowColor = [UIColor whiteColor];
        name.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:name];
        
//        UILabel *byLabel = [[UILabel alloc]init];
//        byLabel.frame = CGRectMake(10, 30, 30, 20);
//        byLabel.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
//		byLabel.backgroundColor = [UIColor clearColor];
//		byLabel.font = [UIFont italicSystemFontOfSize:14];
//        byLabel.shadowColor = [UIColor whiteColor];
//        byLabel.shadowOffset = CGSizeMake(0,1);
//        byLabel.text = @"by";
//        [self.contentView addSubview:byLabel];
//        [byLabel release];

//        restaurantName = [[UILabelUnderlined alloc]init];
//        restaurantName.frame = CGRectMake(30, 30, 280, 20);
//        restaurantName.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
//		restaurantName.backgroundColor = [UIColor clearColor];
//		restaurantName.font = [UIFont systemFontOfSize:15];
//        restaurantName.shadowColor = [UIColor whiteColor];
//        restaurantName.shadowOffset = CGSizeMake(0,1);
//        [self.contentView addSubview:restaurantName];
        
//        UIButton *restaurantButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [restaurantButton addTarget:dvc action:@selector(restaurantButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        restaurantButton.frame = CGRectMake(30, 30, 280, 20);
//        [self.contentView addSubview:restaurantButton];
        
        ratingView = [[RatingView alloc] initWithStarSize:20 andLabelVisible:NO];
        ratingView.frame = CGRectMake(10, 60, 100, 20);
        [self.contentView addSubview:ratingView];
        
        UIButton *ratingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ratingButton.frame = CGRectMake(10, 60, 100, 20);
        [ratingButton addTarget:dvc action:@selector(rateItButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:ratingButton];
        
        price = [[UILabel alloc]init];
        price.frame = CGRectMake(265, 7, 50, 20);
        price.textAlignment = UITextAlignmentCenter;
        price.textColor = [UIColor darkGrayColor];
		price.backgroundColor = [UIColor clearColor];
		price.font = [UIFont systemFontOfSize:16];
        price.shadowColor = [UIColor whiteColor];
        price.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:price];
                
        bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bookmarkButton.frame = CGRectMake(240, 50, 24, 21);
        [bookmarkButton addTarget:dvc action:@selector(bookmarkButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

        if (dvc.menu_item.bookmark) {
            [bookmarkButton setImage:[UIImage imageNamed:@"red-heart.png"] forState:UIControlStateNormal];
        } else {
            [bookmarkButton setImage:[UIImage imageNamed:@"29-heart.png"] forState:UIControlStateNormal];            
        }
        [self.contentView addSubview:bookmarkButton];
        
        photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(285, 50, 24, 18);
        [photoButton addTarget:dvc action:@selector(photoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [photoButton setImage:[UIImage imageNamed:@"86-camera.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:photoButton];
        
        
//        singleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 85, 300, 300)];
//        singleImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        singleImageView.layer.borderWidth = 1;
//        [self.contentView addSubview:singleImageView];
//        
//        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [imageButton addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        imageButton.frame = CGRectMake(10, 85, 300, 300);
//        [self.contentView addSubview:imageButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;   
    }
    return self;
}

-(void)loadMenuItem:(MenuItem *)menu_item_passed andRestaurant:(Restaurant *)restaurant
{
    menu_item = menu_item_passed;
    
    name.text = [menu_item.name retain];
    
    CGSize maximumLabelSize = CGSizeMake(name.frame.size.width,9999);
    CGSize expectedLabelSize = [menu_item.name sizeWithFont:[UIFont boldSystemFontOfSize:17] 
                                  constrainedToSize:maximumLabelSize 
                                      lineBreakMode:UILineBreakModeWordWrap];
    
    name.frame = CGRectMake(10, 7, expectedLabelSize.width, expectedLabelSize.height);
    ratingView.frame = CGRectMake(10, expectedLabelSize.height + 15, ratingView.frame.size.width, ratingView.frame.size.height);
    photoButton.frame = CGRectMake(photoButton.frame.origin.x, expectedLabelSize.height + 15, photoButton.frame.size.width, photoButton.frame.size.height);
    bookmarkButton.frame = CGRectMake(bookmarkButton.frame.origin.x, expectedLabelSize.height + 15, bookmarkButton.frame.size.width, bookmarkButton.frame.size.height);
    
    restaurantName.text = [restaurant.name retain];
    price.text = [NSString stringWithFormat:@"$%.2f", menu_item.price];
    
    if ([price.text isEqualToString:@"$0.00"]) {
        price.text = @"";
    }
    
    [ratingView loadRating:menu_item.rating];
    
//    NSMutableArray *arrayOfURLStrings = [[NSMutableArray alloc]init];
//    for (NSDictionary *pictDict in menu_item.pictures) {
//        
//        UIDeviceHardware *h=[[UIDeviceHardware alloc] init];
//        if ([[h platformString] isEqualToString:@"iPhone 4"]) {
//            NSLog(@"we have an iPhone 4");
//            [arrayOfURLStrings addObject:[pictDict objectForKey:@"640px"]];
//        } else {
//            [arrayOfURLStrings addObject:[pictDict objectForKey:@"300px"]];
//        }
//    }
//    
//    NSLog(@"arrayOfURLStrings: %@", arrayOfURLStrings);
//    
//    UIImage *noImage = [UIImage imageNamed:@"no-image-300.png"];
//    NSMutableArray *imageViewArray = [[NSMutableArray alloc]init];
//    
//    for (int i=0; i < [arrayOfURLStrings count]; i++) {
//        UIImageView *imageView = [[UIImageView alloc]init];
//        [imageView setImageWithURL:[NSURL URLWithString:[arrayOfURLStrings objectAtIndex:i]] placeholderImage:noImage];
//        [imageViewArray addObject:imageView];
//    }
//        
//    if ([arrayOfURLStrings count] == 0) {
//        //singleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 85, 300, 300)];
//        singleImageView.image = noImage;
//        //singleImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        //singleImageView.layer.borderWidth = 1;
//        //[self.contentView addSubview:singleImageView];
//        
//    } else {
//        //singleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 85, 300, 300)];
//        [singleImageView setImageWithURL:[NSURL URLWithString:[arrayOfURLStrings objectAtIndex:0]] placeholderImage:noImage];
//        //singleImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        //singleImageView.layer.borderWidth = 1;
//        //[self.contentView addSubview:singleImageView];
//    }
////    } else {
////        
////        for (UIView *view in self.contentView.subviews) {
////            if (view == singleImageView) {
////                [singleImageView removeFromSuperview];
////            }
////        }
////        
////        viewForScrollView = [[UIView alloc]initWithFrame:CGRectMake(10, 85, 300, 300)];
////        svimage = [[IGUIScrollViewImage alloc] init];  
////        [svimage setContentArray:imageViewArray]; 
////        [svimage setBackGroudColor:[UIColor clearColor]];
////        [svimage setWidth:300 andHeight:300];
////        [svimage enablePageControlOnBottom];  
////        svimage.scrollView.showsHorizontalScrollIndicator = FALSE;
////        viewForScrollView.layer.borderColor = [UIColor lightGrayColor].CGColor;
////        viewForScrollView.layer.borderWidth = 1;
////        [viewForScrollView addSubview:[svimage getWithPosition:0]];
////        [self.contentView addSubview:viewForScrollView];
////    }
//     
    
}

//-(void) imageButtonPressed:(id)sender {
//    if ([menu_item.pictures count] > 0) {
//        iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//        PhotoViewer *photoViewer = [[PhotoViewer alloc]init];            
//        [photoViewer setupScrollView:menu_item.pictures];
//        photoViewer.navItem.title = restaurantName.text; //[NSString stringWithFormat:@"%@", menu_item.name];
//        photoViewer.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [appDelegate.tabBarController presentModalViewController:photoViewer animated:YES];
//        [photoViewer release];
//    }
//}

-(void)cameraButtonPressed:(id)sender {
    //[takePhoto loadPhotoForRestaurant:restaurant];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [singleImageView release];
    [price release];
    [ratingView release];
    [name release];
    [restaurantName release];
    [svimage release];
    [viewForScrollView release];
    [super dealloc];
}

@end
