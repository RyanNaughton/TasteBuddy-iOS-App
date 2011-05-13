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

#import "IGUIScrollViewImage.h"

@implementation DishHeaderCell

@synthesize name, price, ratingView, restaurantName, svimage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cameraButton setBackgroundImage:[UIImage imageNamed:@"86-camera.png"] forState:UIControlStateNormal];
        [cameraButton addTarget:self action:@selector(cameraButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        cameraButton.frame = CGRectMake(230, 10, 24, 18);
        [self.contentView addSubview:cameraButton];

        
        name = [[UILabel alloc]init];
        name.frame = CGRectMake(10, 7, 240, 20);
        name.adjustsFontSizeToFitWidth = TRUE;
        name.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		name.backgroundColor = [UIColor clearColor];
		name.font = [UIFont boldSystemFontOfSize:18];
        name.shadowColor = [UIColor whiteColor];
        name.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:name];
        
        UILabel *byLabel = [[UILabel alloc]init];
        byLabel.frame = CGRectMake(10, 30, 30, 20);
        byLabel.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		byLabel.backgroundColor = [UIColor clearColor];
		byLabel.font = [UIFont italicSystemFontOfSize:14];
        byLabel.shadowColor = [UIColor whiteColor];
        byLabel.shadowOffset = CGSizeMake(0,1);
        byLabel.text = @"by";
        [self.contentView addSubview:byLabel];
        [byLabel release];

        restaurantName = [[UILabel alloc]init];
        restaurantName.frame = CGRectMake(30, 30, 280, 20);
        restaurantName.textColor = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0];
		restaurantName.backgroundColor = [UIColor clearColor];
		restaurantName.font = [UIFont systemFontOfSize:15];
        restaurantName.shadowColor = [UIColor whiteColor];
        restaurantName.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:restaurantName];
        
        ratingView = [[RatingView alloc] initWithStarSize:20 andLabelVisible:YES];
        ratingView.frame = CGRectMake(10, 60, 100, 20);
        [self.contentView addSubview:ratingView];

        price = [[UILabel alloc]init];
        price.frame = CGRectMake(260, 7, 50, 20);
        price.textAlignment = UITextAlignmentCenter;
        price.textColor = [UIColor darkGrayColor];
		price.backgroundColor = [UIColor clearColor];
		price.font = [UIFont systemFontOfSize:16];
        price.shadowColor = [UIColor whiteColor];
        price.shadowOffset = CGSizeMake(0,1);
        [self.contentView addSubview:price];
        
        UIImage *image1 = [UIImage imageNamed:@"pizza.png"];
        UIImage *image2 = [UIImage imageNamed:@"taco.png"];
        UIImage *image3 = [UIImage imageNamed:@"cheeseburger.png"];
        NSArray *imageArray = [NSArray arrayWithObjects:image1, image2, image3, nil];
        
        UIView *viewForScrollView = [[UIView alloc]initWithFrame:CGRectMake(10, 85, 300, 300)];
        svimage = [[IGUIScrollViewImage alloc] init];  
        [svimage setBackGroudColor:[UIColor clearColor]];
        [svimage setContentArray:imageArray];  
        [svimage setWidth:300 andHeight:300];
        [svimage enablePageControlOnBottom];  
        [viewForScrollView addSubview:[svimage getWithPosition:0]]; 
        svimage.scrollView.showsHorizontalScrollIndicator = FALSE;
        [self.contentView addSubview:viewForScrollView];
        [viewForScrollView release];
        
    }
    return self;
}

-(void)loadMenuItem:(MenuItem *)menu_item andRestaurant:(Restaurant *)restaurant
{
    name.text = [NSString stringWithFormat:@"%@", menu_item.name];
    restaurantName.text = [NSString stringWithFormat:@"%@", restaurant.name];
    price.text = [NSString stringWithFormat:@"$%.2f", menu_item.price];

    //[imageView setImageWithURL:[NSURL URLWithString:[[menu_item.pictures objectAtIndex:0] objectForKey:@"300px"]]
    //          placeholderImage:[UIImage imageNamed:@"restaurant-icon.gif"]];
    
}

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
    [price release];
    [ratingView release];
    [name release];
    [restaurantName release];
    [svimage release];
    [super dealloc];
}

@end
