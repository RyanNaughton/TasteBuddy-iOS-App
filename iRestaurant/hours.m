//
//  hours.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "hours.h"


@implementation Hours

@synthesize firstOpeningHours, secondOpeningHours;

- (void)dealloc {
    
    [super dealloc];
}
-(id) initWithArray:(NSArray *) hoursArray {
    self = [super init];
    if(self) {
        
        firstOpeningHours = [[NSMutableArray alloc] initWithCapacity:7];
        secondOpeningHours = [[NSMutableArray alloc] initWithCapacity:7];
        
        for (NSArray *daysHours in hoursArray) {
            NSDictionary *firstHours = [daysHours objectAtIndex:0];
            NSDictionary *secondHours = [daysHours objectAtIndex:1];
            [firstOpeningHours addObject:[NSString stringWithFormat:@"%@:%@", [firstHours objectForKey:@"h"], [firstHours objectForKey:@"m"]]];
            [secondOpeningHours addObject:[NSString stringWithFormat:@"%@:%@", [secondHours objectForKey:@"h"], [secondHours objectForKey:@"m"]]];
            
            [firstHours release];
            [secondOpeningHours release];
        }
        
        
    }
    return self;
}

-(NSString *) todaysOpeningHours {
    return @"";    
}

-(NSString *) todaysClosingHours {
    return @"";
}


@end
