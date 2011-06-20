//
//  DescriptionCell.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 20/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionCell : UITableViewCell {
    UILabel *text;
}

@property (nonatomic, retain) UILabel *text;

-(void) loadDescription:(NSString *)descriptionPassed;
@end
