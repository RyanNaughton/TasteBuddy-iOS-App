//
//  SearchViewController.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

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
    
//    [
//    {
//    "type": "restaurant",
//    "name": "Boka",
//    "phone": "(312) 337-6070",
//    "address_1": "1729 N Halsted St",
//    "address_2": null,
//    "city_town": "Chicago",
//    "state_province": "IL",
//    "rating_average": 4.1,
//    "tags": [
//    "tag_1",
//    "another_tag"
//    ],
//    "description": "apple & chestnut risotto, pickled turnip, wild mushroom sauce",
//    "price_average": "25",
//    "thumbnail_url": "http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000001/thumb.jpg?1299694640",
//    "photo_urls": [
//    "http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000002/large.jpg?7382698134"
//    ],
//    "id": "497ce971395f2f052a494fd5",
//    "menu_items": [
//    {
//    "type": "menu_item",
//    "name": "Crispy Chicken Thigh",
//    "rating_average": 4.4,
//    "tags": [
//    "salty",
//    "crispy"
//    ],
//    "description": "apple & chestnut risotto, pickled turnip, wild mushroom sauce",
//    "price": "14.00",
//    "photo_urls": [
//    "http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000014/large.jpg?1299694640"
//    ],
//    "id": "497ce971395f2f052a494fd5"
//    }
//    ]
//    }
//    ]
    NSString *json = @"[{\"type\": \"restaurant\", \"name\": \"Boka\", \"phone\": \"(312) 337-6070\", \"address_1\": \"1729 N Halsted St\", \"address_2\": null, \"city_town\": \"Chicago\", \"state_province\": \"IL\", \"rating_average\": 4.1, \"tags\": [\"tag_1\", \"another_tag\"], \"description\": \"apple & chestnut risotto, pickled turnip, wild mushroom sauce\", \"price_average\": \"25\", \"thumbnail_url\": \"http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000001/thumb.jpg?1299694640\", \"photo_urls\": [\"http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000002/large.jpg?7382698134\"], \"id\": \"497ce971395f2f052a494fd5\", \"menu_items\": [{\"type\": \"menu_item\", \"name\": \"Crispy Chicken Thigh\", \"rating_average\": 4.4, \"tags\": [\"salty\", \"crispy\"], \"description\": \"apple & chestnut risotto, pickled turnip, wild mushroom sauce\", \"price\": \"14.00\", \"photo_urls\": [\"http://s3.amazonaws.com/menu-pictures-production/attachments/4d77c4329a16857fbe000014/large.jpg?1299694640\"], \"id\": \"497ce971395f2f052a494fd5\"}]}]";

    NSDictionary *dictionary = [json JSONValue];
    NSLog(@"%@", dictionary);
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

-(IBAction) switchSearchView:(id *) sender
{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            NSLog(@"Restaurant.");
            break;
        case 1:
            NSLog(@"Dishes");
            break;
        case 2:
            NSLog(@"Map");
            break;
        default:
            break;
    }   
}
@end
