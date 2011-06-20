//
//  SortAndFilterPreferences.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 31/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "SortAndFilterPreferences.h"


@implementation SortAndFilterPreferences

@synthesize sortIndex;
@synthesize priceIndex;
@synthesize distanceIndex;

-(id) init {
    self = [super init];
    if(self) {
        sortIndex = -1;
        sortIndex = -1;
        distanceIndex = -1;
    }
    return self;
}
-(void) reset {
    sortIndex = -1;
    sortIndex = -1;
    distanceIndex = -1;    
}
@end
