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

@implementation PhotoViewer

@synthesize svimage, navItem, dishNameLabel, commentLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setupScrollView:(NSArray *)arrayOfPhotos {
    //NSLog(@"array of photos: %@", arrayOfPhotos);
    //self.view.backgroundColor = [UIColor blackColor];
    UIImage *noImage = [UIImage imageNamed:@"no-image-300.png"];
    NSMutableArray *imageViewArray = [[NSMutableArray alloc]init];
    NSMutableArray *dishNameLabelArray = [[NSMutableArray alloc]init];
    NSMutableArray *commentLabelArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i < [arrayOfPhotos count]; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImageWithURL:[NSURL URLWithString:[[arrayOfPhotos objectAtIndex:i] objectForKey:@"300px"]] placeholderImage:noImage];
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
    [svimage setDishNameLabelArray:dishNameLabelArray andCommentLabelArray:commentLabelArray];
    [svimage setWidth:320 andHeight:320];
    [svimage enablePageControlOnBottom];  
    [viewForScrollView addSubview:[svimage getWithPosition:0]]; 
    svimage.scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:viewForScrollView];
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
