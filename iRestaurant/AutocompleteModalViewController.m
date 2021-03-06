//
//  AutocompleteModalViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 19/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "AutocompleteModalViewController.h"
#import "FindAutocompleteTableViewController.h"
#import "NearAutocompleteTableViewController.h"
#import "SearchViewController.h"
#import "SortAndFilterPreferences.h"

@implementation AutocompleteModalViewController

@synthesize tableView, searchView, termField, nearField, findAutocompleteTableViewController, nearAutocompleteTableViewController, autocompleteService, searchViewController, cancelButton, whatBGBox, whereBGBox, lastNear, nearbyButton, festivalId, isFestivalSearch;

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
    [tableView release];
    [searchView release];
    [termField release];
    [nearField release];
    [cancelButton release];
    [nearbyButton release];
    [findAutocompleteTableViewController release];
    [nearAutocompleteTableViewController release];
    [autocompleteService release];
    [searchViewController release];
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
    
    self.tableView.alpha = 0;
    autocompleteService = [[AutocompleteService alloc] initWithDelegate: findAutocompleteTableViewController];
    
    if(isFestivalSearch) {
        autocompleteService.isFestivalSearch = isFestivalSearch;
        autocompleteService.festivalId = festivalId;
    } 
    
    UIImage *greyButtonImage = [[UIImage imageNamed:@"grey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    [cancelButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
    [nearbyButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
    
    UIImage *textBox = [[UIImage imageNamed:@"text-area-image.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
    whatBGBox.image = textBox;
    whereBGBox.image = textBox;

    if ([nearField.text isEqualToString:@"Current Location"]) {
        nearField.textColor = [UIColor blueColor];
    }
    lastNear = [nearField.text retain];
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

-(IBAction) autocomplete:(id) sender
{
    //Need this for setting the autocomplete to show on searchViewAnimateIn
    if((UITextField *) sender == termField) {
        tableView.delegate = findAutocompleteTableViewController;
        tableView.dataSource = findAutocompleteTableViewController;
        autocompleteService.delegate = findAutocompleteTableViewController;
        findAutocompleteTableViewController.tableView = self.tableView;
    } else {
        if ([nearField.text isEqualToString:@"Current Location"]) {
            nearField.textColor = [UIColor blueColor];
        } else {
            nearField.textColor = [UIColor blackColor];
        }
        
        if([lastNear isEqualToString:@"Current Location"] && [nearField.text isEqualToString:@"Current Locatio"]) {
            nearField.text = @"";
        } else {
            tableView.delegate = nearAutocompleteTableViewController;
            tableView.dataSource = nearAutocompleteTableViewController;
            autocompleteService.delegate = nearAutocompleteTableViewController;
            nearAutocompleteTableViewController.tableView = self.tableView;
            lastNear = [nearField.text retain];
        }
    }
    
    [tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    //Only trigger service call when term length is long enough
    if ([((UITextField *) sender).text length] > 2) {
        if((UITextField *) sender == termField) {
            [autocompleteService performAutoCompleteWithTerm:termField.text andPlace:nearField.text andIsNearAutoComplete:NO];
        } else {
            [autocompleteService performAutoCompleteWithTerm:termField.text andPlace:nearField.text andIsNearAutoComplete:YES];
        }
    } else {
        
        if([tableView.dataSource isKindOfClass:[NearAutocompleteTableViewController class]]) {
            [(NearAutocompleteTableViewController *)tableView.dataSource autocompleteFinished:[[NSDictionary alloc] init] withLastNear:@""];
        } else if([tableView.dataSource isKindOfClass:[FindAutocompleteTableViewController class]]) {
            [(FindAutocompleteTableViewController *)tableView.dataSource autocompleteFinished:[[NSDictionary alloc] init] withLastNear:@""];            
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [searchViewController.searchService searchByTerm:termField.text andNear:nearField.text];
    [searchViewController switchSearchView:(id) searchViewController.lastSender];
    [searchViewController resultsLoading];
    [searchViewController.sortAndFilterPreferences reset];
    searchViewController.fakeTermField.text = termField.text;
    //[self dismissModalViewControllerAnimated:YES];
    [self cancel];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField.text length] > 0) {
        [self autocomplete:textField];
    }
    return YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [termField becomeFirstResponder];
    [self autocomplete:termField]; //Force the appropriate TableView to kick in
    
    [autocompleteService.jsonDictionary removeObjectForKey:@"auth_token"];
    searchView.center = CGPointMake(searchView.center.x, searchView.frame.size.height / 2 );
    tableView.frame = CGRectMake(0, searchView.frame.size.height, self.view.frame.size.width,  125);
    tableView.alpha = 0;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string && [string length] && [textField.text isEqualToString:@"Current Location"]) {
        return NO;
    }
    
    return YES;
}

-(void) viewDidDisappear:(BOOL)animated {
    [self autocomplete:termField];
}
-(IBAction) cancel
{
    [searchViewController updateSearchTermField];
    //[self dismissModalViewControllerAnimated:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.333];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.alpha = 0.0;
    self.view.frame = CGRectMake(0, -20, 320, 366);
    tableView.alpha = 0.0;
    [UIView setAnimationDidStopSelector:@selector(removeView)];
    [UIView commitAnimations];
}

-(IBAction) nearbyButtonPressed
{
    termField.text = @"";
    nearField.text = @"Current Location";
    [searchViewController.searchService searchByTerm:termField.text andNear:nearField.text];
    [searchViewController switchSearchView:(id) searchViewController.lastSender];
    [searchViewController resultsLoading];
    searchViewController.fakeTermField.text = termField.text;
    [self cancel];

}

-(void)removeView {
    [self.view removeFromSuperview];
}

@end
