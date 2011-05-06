//
//  RestaurantTagsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "RestaurantTagsCell.h"
#import "JSON.h"
#import "IGUIScrollViewCanvas.h"
#import "Restaurant.h"
#import "Tag.h"
#import "TagService.h"
#import "TagButton.h"
#import "iRestaurantAppDelegate.h"
#import "RestaurantTaggingService.h"
#import "AuthenticationResponse.h"

@implementation RestaurantTagsCell
@synthesize tagService, restaurant, tagButtons, restaurantTaggingService, tags, tagValues;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *topRounding = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top-rounding.png"]];
        topRounding.frame = CGRectMake(0, 10, 320, 15);
        [self.contentView addSubview:topRounding];
        [topRounding release];
        
        UILabel *tagsLabel = [[UILabel alloc]init];
        tagsLabel.frame = CGRectMake(10, 25, 120, 15);
        tagsLabel.textColor = [UIColor blackColor];
        tagsLabel.backgroundColor = [UIColor clearColor];
        tagsLabel.font = [UIFont boldSystemFontOfSize:16];
        tagsLabel.shadowColor = [UIColor whiteColor];
        tagsLabel.shadowOffset = CGSizeMake(0,1);
        tagsLabel.text = @"Quick Review";
        [self.contentView addSubview:tagsLabel];
        [tagsLabel release];
        
        UILabel *tagsSubLabel = [[UILabel alloc]init];
        tagsSubLabel.adjustsFontSizeToFitWidth = TRUE;
        tagsSubLabel.frame = CGRectMake(10, 45, 300, 15);
        tagsSubLabel.textColor = [UIColor darkGrayColor];
        tagsSubLabel.backgroundColor = [UIColor clearColor];
        tagsSubLabel.font = [UIFont systemFontOfSize:14];
        tagsSubLabel.shadowColor = [UIColor whiteColor];
        tagsSubLabel.shadowOffset = CGSizeMake(0,1);
        tagsSubLabel.text = @"Touch the adjectives that describe this restaurant";
        [self.contentView addSubview:tagsSubLabel];
        [tagsSubLabel release];

        tagService =[[TagService alloc] initWithDelegate:self];
        restaurantTaggingService  = [[RestaurantTaggingService alloc] initWithDelegate:self];
        tagButtons = [[NSMutableArray alloc] init];
        tagValues = [[NSMutableArray alloc] init];
        [tagService getTags];
        
    }
    return self;
}

-(void) loadRestaurant:(Restaurant *)restaurantPassed {
    restaurant = restaurantPassed;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) tagsRetrieved:(NSMutableArray *)tagsRetrieved {
    tags = tagsRetrieved;
    // Contains entire tag scrolling area in cell
    UIView *tagScrollContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 320, 130)]; 
    
    int column = 1;
    int positionInColumn = 1;
    int btnWidth = 145;
    int btnHeight = 30;
    int xPadding = 10;
    int yPadding = 5;

    NSMutableArray *viewsArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i < [tags count]; i++) {
        UIView *viewForTagButtons;
        if ((positionInColumn == 1) && (column == 1)) {
            viewForTagButtons = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 130)];
        }
        
        TagButton *tagButton = (TagButton *)[TagButton buttonWithType:UIButtonTypeCustom];
        [tagButton prepareButton];
        [tagButtons addObject:tagButton];
        [tagButton addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        Tag *tag = (Tag *)[tags objectAtIndex:i];

        [tagButton loadTag:tag];
        [tagValues addObject:tag.name];
        
        tagButton.frame = CGRectMake(((column * btnWidth) - btnWidth + (xPadding * column)), ((btnHeight * positionInColumn) - btnHeight + (yPadding * positionInColumn)), btnWidth, btnHeight);
        [viewForTagButtons addSubview:tagButton];
        
        if ((positionInColumn == 3) && (column == 2)) {
            // end of view
            [viewsArray addObject:viewForTagButtons];
            
            viewForTagButtons = nil;
            [viewForTagButtons release];
            
            column = 1;
            positionInColumn = 1;
            
        } else {
            if (positionInColumn == 3) {
                column++;
                positionInColumn = 1;
            } else {
                positionInColumn ++;
            }
        }
    }
    
    IGUIScrollViewCanvas *scrollView = [[IGUIScrollViewCanvas alloc] init];  
    [scrollView setBackGroudColor:[UIColor clearColor]];
    [scrollView setContentArray:viewsArray];  
    [scrollView setWidth:320 andHeight:130];
    [scrollView enablePageControlOnBottom];  
    [tagScrollContainer addSubview:[scrollView getWithPosition:0]]; 
    [self.contentView addSubview:tagScrollContainer];
    [tagScrollContainer release];

}
                                
-(void)tagButtonPressed:(id)sender {
    iRestaurantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Tag *tag = [tags objectAtIndex:[tagButtons indexOfObject:sender]];
    [restaurantTaggingService tagRestaurant:restaurant withTag:tag.name andAuthToken:appDelegate.authenticationResponse.authentication_token];
}

-(void) doneTagging:(NSMutableArray *) tagsFromUser {
    for (Tag* tagForUser in tagsFromUser) {
        NSUInteger indexOfTag = [tagValues indexOfObject:tagForUser.name];
        Tag *tag = [tags objectAtIndex:indexOfTag];
        TagButton *button = [tagButtons objectAtIndex:indexOfTag]; 
        if([tag.name isEqualToString:tagForUser.name]) {
            tag.isUserTag = true;
            tag.count = tagForUser.count;
            [button loadTag:tag];
        }
    }

}


- (void)dealloc
{
    [restaurantTaggingService release];
    [tags release];
    [tagValues release];
    [tagButtons release];
    [restaurant release];
    [tagService release];
    [super dealloc];
}

@end
