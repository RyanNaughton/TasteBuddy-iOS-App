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

@implementation RestaurantTagsCell
@synthesize circlePlus, circleCheck;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        circlePlus = [UIImage imageNamed:@"33-circle-plus.png"];
        circleCheck = [UIImage imageNamed:@"39-circle-check.png"];
        
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
        tagsSubLabel.text = @"Up-vote adjectives that describe this restaurant";
        [self.contentView addSubview:tagsSubLabel];
        [tagsSubLabel release];
        
        // Contains entire tag scrolling area in cell
        UIView *tagScrollContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 320, 130)]; 
        
        NSString *allTags = @"[\"aged\",\"aromatic\",\"authentic\",\"baked\",\"bite-size\",\"bitter\",\"bland\",\"blazed\",\"boiled\",\"braised\",\"browned\",\"burnt\",\"buttery\",\"caked\",\"candied\",\"caramelized\",\"char-broiled\",\"cheesy\",\"chilled\",\"chocolaty\",\"chunky\",\"cinnamon\",\"classic\",\"cold\",\"colorful\",\"corn-fed\",\"crafted\",\"creamy\",\"crisp\",\"crumbly\",\"crunchy\",\"cured\",\"decadent\",\"delectable\",\"delicate\",\"delicious\",\"delightful\",\"distinctive\",\"doughy\"]";
                
        NSArray *tags = [allTags JSONValue];    
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
            
            UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [tagButton addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            NSString *tag = [tags objectAtIndex:i];
            
            // need to get real vote count, obviously.
            int tagVoteCount = i; 
            
            [tagButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            tagButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            tagButton.frame = CGRectMake(((column * btnWidth) - btnWidth + (xPadding * column)), ((btnHeight * positionInColumn) - btnHeight + (yPadding * positionInColumn)), btnWidth, btnHeight);
            
            UILabel *tagName = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 110, 15)];
            tagName.backgroundColor = [UIColor clearColor];
            tagName.font = [UIFont systemFontOfSize:13];
            tagName.text = [NSString stringWithFormat:@"%@ (%i)", tag, tagVoteCount];
            [tagButton addSubview:tagName];
            [tagName release];
            
            UIImageView *plusButton = [[UIImageView alloc]initWithImage:circlePlus];
            plusButton.frame = CGRectMake(120, 7, 15, 15);
            plusButton.alpha = 0.7;
            [tagButton addSubview:plusButton];
            [plusButton release];
            
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
    return self;
}

-(void) loadRestaurant:(Restaurant *)restaurant {
}

-(void)tagButtonPressed:(id)sender {
    UIButton *tagButton = (UIButton *)sender;
    
    for (UIView *view in tagButton.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)view;
            if (imageView.image == circlePlus) {
                [imageView removeFromSuperview];
                
                UIImage *greyButtonImage = [[UIImage imageNamed:@"grey-button.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0];
                [tagButton setBackgroundImage:greyButtonImage forState:UIControlStateNormal];
                
                UIImageView *checkmark = [[UIImageView alloc]initWithImage:circleCheck];
                checkmark.frame = CGRectMake(120, 7, 15, 15);
                checkmark.alpha = 0.7;
                [tagButton addSubview:checkmark];
                [checkmark release];
                
            } else if (imageView.image == circleCheck){
                
                [imageView removeFromSuperview];
                [tagButton setBackgroundImage:nil forState:UIControlStateNormal];
                
                UIImageView *plus = [[UIImageView alloc]initWithImage:circlePlus];
                plus.frame = CGRectMake(120, 7, 15, 15);
                plus.alpha = 0.7;
                [tagButton addSubview:plus];
                [plus release];
            }
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
