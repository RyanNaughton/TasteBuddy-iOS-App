//
//  SortAndFilterPreferences.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 31/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SortAndFilterPreferences : NSObject {
    int sortIndex;
    int priceIndex;
    int distanceIndex;
}
@property (nonatomic, assign) int sortIndex;
@property (nonatomic, assign) int priceIndex;
@property (nonatomic, assign) int distanceIndex;

-(void) reset;
@end
