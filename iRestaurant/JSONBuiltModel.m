//
//  JSONBuiltModel.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 27/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "JSONBuiltModel.h"


@implementation JSONBuiltModel

-(void) checkForNull:(NSString *)stringToCheck {
    if([@"<null>" isEqualToString:stringToCheck]) {
        stringToCheck = @"";
    }
}

@end
