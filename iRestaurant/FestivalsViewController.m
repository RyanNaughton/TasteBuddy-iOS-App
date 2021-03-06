//
//  FestivalsViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "FestivalsViewController.h"

@implementation FestivalsViewController

@synthesize festivalsTableViewController, service;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    [self setTitle:@"Festivals"];
    UIImageView *appNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"festivalsLogo.png"]];
    appNameImageView.frame = CGRectMake(-10, -3, 150, 44);
    appNameImageView.contentMode = UIViewContentModeRight;
    self.navigationItem.titleView = appNameImageView;

    
    service = [[FestivalsService alloc] initWithDelegate:self];
    [service getFestivals];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated {
    if (festivalsTableViewController.festivals == NULL || [festivalsTableViewController.festivals count] == 0) {
        [service getFestivals];
    }
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

-(void) dealloc {
    [festivalsTableViewController release];
    [service release];
    [super dealloc];
}

-(void) festivalsRetrieved:(NSMutableArray *)festivals {
    festivalsTableViewController.festivalsViewController = self;
    festivalsTableViewController.festivals = festivals;
    [festivalsTableViewController.tableView reloadData];
}

@end
