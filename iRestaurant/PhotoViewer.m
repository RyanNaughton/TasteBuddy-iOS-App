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

@synthesize svimage, navItem, label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setupScrollView:(NSArray *)arrayOfPhotos {
    
    self.view.backgroundColor = [UIColor blackColor];
    UIImage *noImage = [UIImage imageNamed:@"no-image-300.png"];
    NSMutableArray *imageViewArray = [[NSMutableArray alloc]init];
    NSMutableArray *labelArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i < [arrayOfPhotos count]; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImageWithURL:[NSURL URLWithString:[[arrayOfPhotos objectAtIndex:i] objectForKey:@"300px"]] placeholderImage:noImage];
//        UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arrayOfURLStrings objectAtIndex:i]]]];
        [imageViewArray addObject:imageView];
        [labelArray addObject:[[arrayOfPhotos objectAtIndex:i] objectForKey:@"menu_item_name"]];
    }
    
    UIView *viewForScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 320)];
    
    svimage = [[IGUIScrollViewImage alloc] init];  
    svimage.delegate = self;
    [svimage setBackGroudColor:[UIColor clearColor]];
    [svimage setContentArray:imageViewArray]; 
    [svimage setLabelArray:labelArray];
    [svimage setWidth:320 andHeight:320];
    [svimage enablePageControlOnBottom];  
    [viewForScrollView addSubview:[svimage getWithPosition:0]]; 
    svimage.scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:viewForScrollView];
    [viewForScrollView release];
}

-(void) setImageLabel:(NSString *)labelString {
    if ((labelString != NULL) && (![labelString isKindOfClass:[NSNull class]])) {
        label.text = [labelString retain];
    } else {
        label.text = @"";
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
