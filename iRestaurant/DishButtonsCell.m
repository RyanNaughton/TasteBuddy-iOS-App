//
//  DishButtonsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/18/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishButtonsCell.h"
#import "DishViewController.h"
#import "MenuItem.h"
#import "Restaurant.h"

@implementation DishButtonsCell
@synthesize dishViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andParentView:(DishViewController *)dishViewController_passed
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        dishViewController = dishViewController_passed;
        
        UIImage *greyButtonImage = [[UIImage imageNamed:@"darkgrey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        UIImage *darkergreyButtonImage = [[UIImage imageNamed:@"darkergrey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
        CGRect iconFrame = CGRectMake(14, 14, 12, 12);
        
        // CALL ==============
        
        UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [callButton addTarget:dishViewController action:@selector(callButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [callButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
        [callButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        callButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        callButton.frame = CGRectMake(10, 20, 300, 40);
        [callButton setTitle:[NSString stringWithFormat:@"Call: %@", dishViewController_passed.restaurant.phone] forState:UIControlStateNormal];
        [self.contentView addSubview:callButton];
        
        UIImageView *phoneImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"75-phone.png"]];
        phoneImage.frame = iconFrame;
        phoneImage.contentMode = UIViewContentModeScaleAspectFill;
        phoneImage.alpha = 0.8;
        [callButton addSubview:phoneImage];
        //[phoneImage release];
        
        // RATE IT ============
        
//        UIButton *rateItButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [rateItButton addTarget:dishViewController action:@selector(rateItButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [rateItButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
//        [rateItButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        rateItButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//        rateItButton.frame = CGRectMake(165, 10, 145, 40);
//        [rateItButton setTitle:@"Rate it!" forState:UIControlStateNormal];
//        [self.contentView addSubview:rateItButton];
//        
//        UIImageView *starImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"28-star.png"]];
//        starImage.frame = iconFrame;
//        starImage.contentMode = UIViewContentModeScaleAspectFill;
//        starImage.alpha = 0.8;
//        [rateItButton addSubview:starImage];
        //[starImage release];
        
        // MAP IT ============
        
        UIButton *mapItButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [mapItButton addTarget:dishViewController action:@selector(mapItButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [mapItButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
        [mapItButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        mapItButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        mapItButton.frame = CGRectMake(10, 70, 300, 40); //CGRectMake(10, 60, 145, 40);
        [mapItButton setTitle:[NSString stringWithFormat:@"Map: %@", dishViewController_passed.restaurant.address_1] forState:UIControlStateNormal];
        [self.contentView addSubview:mapItButton];
        
        UIImageView *addressImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"07-map-marker.png"]];
        addressImage.frame = iconFrame;
        addressImage.contentMode = UIViewContentModeScaleAspectFill;
        addressImage.alpha = 0.8;
        [mapItButton addSubview:addressImage];
        //[addressImage release];
        
        // ADD PHOTO ============
        
//        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [photoButton addTarget:dishViewController action:@selector(photoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [photoButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
//        [photoButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        photoButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//        photoButton.frame = CGRectMake(165, 60, 145, 40);
//        [photoButton setTitle:@"  Add Photo" forState:UIControlStateNormal];
//        [self.contentView addSubview:photoButton];
//        
//        UIImageView *cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"86-camera.png"]];
//        cameraImage.frame = iconFrame;
//        cameraImage.contentMode = UIViewContentModeScaleAspectFill;
//        cameraImage.alpha = 0.8;
//        [photoButton addSubview:cameraImage];
//        //[addressImage release];
        
        // MENUS ============
        
//        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [menuButton addTarget:dishViewController action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [menuButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
//        [menuButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        menuButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//        menuButton.frame = CGRectMake(10, 110, 145, 40);
//        [menuButton setTitle:@"Menus" forState:UIControlStateNormal];
//        [self.contentView addSubview:menuButton];
//        
//        UIImageView *menuImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"48-fork-and-knife.png"]];
//        menuImage.frame = iconFrame;
//        menuImage.contentMode = UIViewContentModeScaleAspectFill;
//        menuImage.alpha = 0.8;
//        [menuButton addSubview:menuImage];
        //[menuImage release];
        
        // BOOKMARK ============
        
//        UIButton *bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [bookmarkButton addTarget:dishViewController action:@selector(bookmarkButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [bookmarkButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        bookmarkButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//        CGRect fullWidthFrame = CGRectMake(10, 110, 300, 40);
//        //CGRect btmRtFrame = CGRectMake(165, 110, 145, 40);
//        bookmarkButton.frame =  fullWidthFrame;
//        UIImageView *bookmarkImage;
//        if (dishViewController.menu_item.bookmark) {
//            [bookmarkButton setTitle:@"Remove from Favorites" forState:UIControlStateNormal];
//            [bookmarkButton setBackgroundImage:darkergreyButtonImage forState:UIControlStateNormal];
//            [bookmarkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            bookmarkImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"20-no.png"]];
//        } else {
//            [bookmarkButton setTitle:@"Add to Favorites" forState:UIControlStateNormal];
//            [bookmarkButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
//            [bookmarkButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//            bookmarkImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"29-heart.png"]];
//        }
//        [self.contentView addSubview:bookmarkButton];        
//        bookmarkImage.frame = iconFrame;
//        bookmarkImage.contentMode = UIViewContentModeScaleAspectFill;
//        bookmarkImage.alpha = 0.8;
//        [bookmarkButton addSubview:bookmarkImage];
//        //[menuImage release];
        
        self.selectionStyle = UITableViewCellEditingStyleNone;
        
    }
    return self;
}

-(void)loadRestaurant:(Restaurant *)restaurant_passed {
    //[generalInfoButton setTitle:[NSString stringWithFormat:@"%@ Info", [restaurant_passed.name retain]] forState:UIControlStateNormal];
}

-(void)generalInfoButtonPressed:(id)sender {
}

-(void)bookmarkItButtonPressed:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{   
    [super dealloc];
}

@end
