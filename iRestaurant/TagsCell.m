//
//  RestaurantTagsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/25/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TagsCell.h"
#import "JSON.h"
#import "IGUIScrollViewCanvas.h"
#import "Restaurant.h"
#import "MenuItem.h"
#import "Tag.h"
#import "TagService.h"
#import "TagButton.h"
#import "iRestaurantAppDelegate.h"
#import "TaggingService.h"
#import "AuthenticationResponse.h"
    
@implementation TagsCell
@synthesize tagService, restaurant, menuItem, tagButtons, restaurantTaggingService, tags, tagValues;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        menuItem = nil;
        restaurant = nil;
        
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
        tagsSubLabel.text = @"Touch adjectives that describe this restaurant";
        [self.contentView addSubview:tagsSubLabel];
        [tagsSubLabel release];

        tagService =[[TagService alloc] initWithDelegate:self];
        restaurantTaggingService  = [[TaggingService alloc] initWithDelegate:self];
        tagButtons = [[NSMutableArray alloc] init];
        tagValues = [[NSMutableArray alloc] init];
        [tagService getTags];
        self.selectionStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}

-(void) loadRestaurant:(Restaurant *)restaurantPassed {
    restaurant = [restaurantPassed retain];
}

-(void) loadMenuItem:(MenuItem *)menuItemPassed {
    menuItem = [menuItemPassed retain];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) tagsRetrieved:(NSMutableArray *)tagsRetrieved {
    tags = [tagsRetrieved retain];
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
    
    NSMutableArray *tagsToLoad = (restaurant == nil) ? menuItem.tags : restaurant.tags;
    for (Tag *tag in tagsToLoad) {
        NSUInteger indexOfTag = [tagValues indexOfObject:tag.name];
        TagButton *tagButton = [tagButtons objectAtIndex:indexOfTag];
        Tag *tagToUpdate = [tags objectAtIndex:indexOfTag];
        tagToUpdate.isUserTag = tag.isUserTag;
        [tagButton loadTag:tag];
    }
    
    IGUIScrollViewCanvas *scrollView = [[IGUIScrollViewCanvas alloc] init];  
    [scrollView setBackGroudColor: [UIColor clearColor]]; //[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
    [scrollView setContentArray:viewsArray];  
    [scrollView setWidth:320 andHeight:130];
    [scrollView enablePageControlOnBottom];  
    [tagScrollContainer addSubview:[scrollView getWithPosition:0]]; 
    [self.contentView addSubview:tagScrollContainer];
    [tagScrollContainer release];

}
                                
-(void)tagButtonPressed:(id)sender {

    Tag *tag = [tags objectAtIndex:[tagButtons indexOfObject:sender]];
    if (tag.isUserTag) {
        if (restaurant == nil) {
            [restaurantTaggingService deleteTagFromMenuItem:menuItem withTag:tag.name];
        } else {
            [restaurantTaggingService deleteTagFromRestaurant:restaurant withTag:tag.name];
        }
    } else {
        if (restaurant == nil) {
            [restaurantTaggingService tagMenuItem:menuItem withTag:tag.name];
        } else {
            [restaurantTaggingService tagRestaurant:restaurant withTag:tag.name];
        }
    }
}

-(void) doneTagging:(NSMutableArray *) tagsFromUser {
    //Reset Tags
    for (int i = 0; i < [tags count]; i++) {
        Tag *tag = [tags objectAtIndex:i];
        tag.isUserTag = false;
        tag.count = 0;
        TagButton *button = [tagButtons objectAtIndex:i];
        [button loadTag:tag];
    }
    //Update Tags
    for (Tag* tagForUser in tagsFromUser) {
        NSUInteger indexOfTag = [tagValues indexOfObject:tagForUser.name];
        Tag *tag = [tags objectAtIndex:indexOfTag];
        TagButton *button = [tagButtons objectAtIndex:indexOfTag]; 
        if([tag.name isEqualToString:tagForUser.name]) {
            tag.isUserTag = tagForUser.isUserTag;
            tag.count = tagForUser.count;
            [button loadTag:tag];
        }
    }
    
    if(restaurant == nil) {
        menuItem.tags = tags;
    } else {
        restaurant.tags = tags;
    }
}
- (void)dealloc
{
    [restaurantTaggingService release];
    [tags release];
    [tagValues release];
    [tagButtons release];
    [restaurant release];
    [menuItem release];
    [tagService release];
    [super dealloc];
}

@end
