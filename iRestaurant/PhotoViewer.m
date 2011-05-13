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

@synthesize svimage, navItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setupScrollView:(NSArray *)arrayOfURLStrings {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i < [arrayOfURLStrings count]; i++) {
        UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arrayOfURLStrings objectAtIndex:i]]]];
        [imageArray addObject:image];
    }
    
    UIView *viewForScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 320, 320)];
    svimage = [[IGUIScrollViewImage alloc] init];  
    [svimage setBackGroudColor:[UIColor clearColor]];
    [svimage setContentArray:imageArray];  
    [svimage setWidth:320 andHeight:320];
    [svimage enablePageControlOnBottom];  
    [viewForScrollView addSubview:[svimage getWithPosition:0]]; 
    svimage.scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:viewForScrollView];
    [viewForScrollView release];

    
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
