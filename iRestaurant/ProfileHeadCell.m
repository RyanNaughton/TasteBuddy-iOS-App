//
//  ProfileHeadCell.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/4/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "ProfileHeadCell.h"


@implementation ProfileHeadCell
@synthesize nameLabel, reviewsLabel, picturesLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.backgroundColor = [UIColor clearColor];
                
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(10, 10, 250, 25);
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:24];
        [self.contentView addSubview:nameLabel];

        UIImageView *reviewImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"162-receipt.png"]];
        reviewImage.frame = CGRectMake(10, 53, 18, 18);;
        reviewImage.alpha = 0.8;
        [self.contentView addSubview:reviewImage];

        UILabel *youveSubmitted = [[UILabel alloc]init];
        youveSubmitted.frame = CGRectMake(35, 50, 130, 25);
        youveSubmitted.textColor = [UIColor blackColor];
        youveSubmitted.backgroundColor = [UIColor clearColor];
        youveSubmitted.font = [UIFont systemFontOfSize:16];
        youveSubmitted.text = @"You've submitted";
        [self.contentView addSubview:youveSubmitted];
        [youveSubmitted release];

        reviewsLabel = [[UILabel alloc]init];
        reviewsLabel.frame = CGRectMake(163, 50, 250, 25);
        reviewsLabel.textColor = [UIColor blackColor];
        reviewsLabel.backgroundColor = [UIColor clearColor];
        reviewsLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:reviewsLabel];
        
        UIImageView *picturesImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"42-photos.png"]];
        picturesImage.frame = CGRectMake(10, 93, 18, 18);
        picturesImage.alpha = 0.8;
        [self.contentView addSubview:picturesImage];
        
        UILabel *youveTaken = [[UILabel alloc]init];
        youveTaken.frame = CGRectMake(35, 90, 100, 25);
        youveTaken.textColor = [UIColor blackColor];
        youveTaken.backgroundColor = [UIColor clearColor];
        youveTaken.font = [UIFont systemFontOfSize:16];
        youveTaken.text = @"You've taken";
        [self.contentView addSubview:youveTaken];
        [youveTaken release];
        
        picturesLabel = [[UILabel alloc]init];
        picturesLabel.frame = CGRectMake(130, 90, 250, 25);
        picturesLabel.textColor = [UIColor blackColor];
        picturesLabel.backgroundColor = [UIColor clearColor];
        picturesLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:picturesLabel];
    }
    return self;
}

-(void)setUserInfoWithName:(NSString *)name andReviews:(int)reviewsCount andPictures:(int)picturesCount {
    nameLabel.text = [NSString stringWithFormat:@"%@", name];
    reviewsLabel.text = [NSString stringWithFormat:@"%i ratings", reviewsCount];
    picturesLabel.text = [NSString stringWithFormat:@"%i pictures", picturesCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [nameLabel release];
    [reviewsLabel release];
    [picturesLabel release];
    [super dealloc];
}

@end
