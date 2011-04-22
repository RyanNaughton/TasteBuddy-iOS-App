//
//  DishTagsCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/21/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "DishTagsCell.h"
#import "MenuItem.h"
#import "JSON.h"

@implementation DishTagsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void) loadMenuItem:(MenuItem *)menu_item {
    
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
    tagsSubLabel.frame = CGRectMake(10, 45, 300, 15);
    tagsSubLabel.textColor = [UIColor darkGrayColor];
    tagsSubLabel.backgroundColor = [UIColor clearColor];
    tagsSubLabel.font = [UIFont systemFontOfSize:14];
    tagsSubLabel.shadowColor = [UIColor whiteColor];
    tagsSubLabel.shadowOffset = CGSizeMake(0,1);
    tagsSubLabel.text = @"Up-vote adjectives that describe this restaurant";
    [self.contentView addSubview:tagsSubLabel];
    [tagsSubLabel release];
    
    NSString *allTags = @"[\"aged\",\"aromatic\",\"authentic\",\"baked\",\"bite-size\",\"bitter\",\"bland\",\"blazed\",\"boiled\",\"braised\",\"browned\",\"burnt\",\"buttery\",\"caked\",\"candied\",\"caramelized\",\"char-broiled\",\"cheesy\",\"chilled\",\"chocolaty\",\"chunky\",\"cinnamon\",\"classic\",\"cold\",\"colorful\",\"corn-fed\",\"crafted\",\"creamy\",\"crisp\",\"crumbly\",\"crunchy\",\"cured\",\"decadent\",\"delectable\",\"delicate\",\"delicious\",\"delightful\",\"distinctive\",\"doughy\",\"drizzled\",\"dry\",\"dull\",\"encrusted\",\"epicurean\",\"ethnic\",\"exotic\",\"exquisite\",\"extraordinary\",\"festive\",\"filleted\",\"finger-food\",\"fizzy\",\"flaky\",\"flavorful\",\"fleshy\",\"fluffy\",\"fragile\",\"fresh\",\"fried\",\"frosty\",\"fruity\",\"full-bodied\",\"furry\",\"garlicky\",\"generous\",\"gingery\",\"glazed\",\"golden\",\"gooey\",\"gourmet\",\"greasy\",\"grilled\",\"gritty\",\"heaping\",\"hearty\",\"heavenly\",\"homemade\",\"infused\",\"intense\",\"intriguing\",\"juicy\",\"julienne\",\"jumbo\",\"lavish\",\"layered\",\"lean\",\"leathery\",\"lemony\",\"light\",\"loaded\",\"luscious\",\"marinated\",\"mashed\",\"meaty\",\"messy\",\"mild\",\"minty\",\"mixed\",\"moist\",\"mushy\",\"nutmeg\",\"nutritious\",\"nutty\",\"oily\",\"open-faced\",\"organic\",\"palatable\",\"peppery\",\"perfection\",\"petite\",\"pickled\",\"piquant\",\"plump\",\"poached\",\"popular\",\"pounded\",\"prepared\",\"prickly\",\"procen\u00e7al\",\"pulpy\",\"pungent\",\"pur\u00e9ed\",\"rancid\",\"reduced\",\"refreshing\",\"rich\",\"ripe\",\"roasted\",\"rosemary\",\"rubbery\",\"saffron\",\"salty\",\"satiny\",\"saut\u00e9ed\",\"savory\",\"scrumptious\",\"sea\",\"seared\",\"seasoned\",\"sharp\",\"silky\",\"simmered\",\"sizzling\",\"skillfully\",\"slow-cooked\",\"small\",\"smoky\",\"smooth\",\"smothered\",\"soothing\",\"sour\",\"southern\",\"special\",\"spicy\",\"spongy\",\"sprinkled\",\"steamed\",\"steaming\",\"sticky\",\"strong\",\"stuffed\",\"succulent\",\"sugary\",\"superb\",\"sweet\",\"sweet-and-sour\",\"syrupy\",\"tangy\",\"tantalizing\",\"tart\",\"tasteful\",\"tasteless\",\"tasty\",\"tempting\",\"tender\",\"tepid\",\"terrific\",\"thick\",\"thin\",\"thyme\",\"wet\",\"toasted\",\"topped\",\"tossed\",\"tough\",\"traditional\",\"unflavored\",\"unseasoned\",\"vanilla\",\"velvety\",\"vinegary\",\"warm\",\"waxy\",\"whipped\",\"whole\",\"wild\",\"wonderful\",\"woody\",\"yummy\",\"zesty\",\"zippy\"]";
    
    NSArray *tagsArray = [allTags JSONValue];
    
    NSLog(@"tagsArray: %@", tagsArray);

    

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
