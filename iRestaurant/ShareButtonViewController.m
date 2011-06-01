//
//  ShareButtonViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 01/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "ShareButtonViewController.h"


@implementation ShareButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    UIImage *greyButtonImage = [[UIImage imageNamed:@"darkgrey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    CGRect iconFrame = CGRectMake(14, 14, 12, 12);
    
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton addTarget:self action:@selector(photoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [photoButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
    [photoButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    photoButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    photoButton.frame = CGRectMake((320-145)/2, 180, 145, 40);
    [photoButton setTitle:@"  Share Photo" forState:UIControlStateNormal];
    [self.view addSubview:photoButton];
    
    UIImageView *cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"86-camera.png"]];
    cameraImage.frame = iconFrame;
    cameraImage.contentMode = UIViewContentModeScaleAspectFill;
    cameraImage.alpha = 0.8;
    [photoButton addSubview:cameraImage];

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

-(void) photoButtonPressed:(id) sender {
    
}

@end
