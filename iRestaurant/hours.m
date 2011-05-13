//
//  hours.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "hours.h"


@implementation Hours

@synthesize firstOpeningHours, secondOpeningHours, openingTimesCount;

- (void)dealloc {
    
    [firstOpeningHours release];
    [secondOpeningHours release];
    [openingTimesCount release];
    [super dealloc];
}
-(id) initWithArray:(NSArray *) hoursArray {
    self = [super init];
    if(self) {
        
        firstOpeningHours   = [[NSMutableArray alloc] initWithCapacity:7];
        secondOpeningHours  = [[NSMutableArray alloc] initWithCapacity:7];
        openingTimesCount   = [[NSMutableArray alloc] initWithCapacity:7];
        
        for (NSArray *daysHours in hoursArray) {
            [openingTimesCount addObject:[NSNumber numberWithInt:[daysHours count]]];

            NSDictionary *firstOpenHours = [[daysHours objectAtIndex:0] objectForKey:@"open"];
            NSDictionary *firstCloseHours = [[daysHours objectAtIndex:0] objectForKey:@"close"];
            
            [firstOpeningHours addObject:[NSString stringWithFormat:@"%@:%@ - %@:%@", [firstOpenHours objectForKey:@"h"], [firstOpenHours objectForKey:@"m"], [firstCloseHours objectForKey:@"h"], [firstCloseHours objectForKey:@"m"]]];

            
            if([daysHours count] > 1) {
                NSDictionary *secondOpenHours = [[daysHours objectAtIndex:1] objectForKey:@"open"];
                NSDictionary *secondCloseHours = [[daysHours objectAtIndex:1] objectForKey:@"close"];
                [secondOpeningHours addObject:[NSString stringWithFormat:@"%@:%@ - %@:%@",  [secondOpenHours objectForKey:@"h"], [secondOpenHours objectForKey:@"m"], [secondCloseHours objectForKey:@"h"], [secondCloseHours objectForKey:@"m"]]];
                
            } else {
                [secondOpeningHours addObject:@"-"];
            }
            
            
        }

    }
    return self;
}

-(NSString *) todaysFirstOpeningHours {    
    return [firstOpeningHours objectAtIndex:[self dayNumber]];    
}

-(NSString *) todaysSecondOpeningHours {
    return [secondOpeningHours objectAtIndex:[self dayNumber]];   
}

-(int) todaysOpeningTimesCount {
    return [[openingTimesCount objectAtIndex:[self dayNumber]] intValue];
}


-(int) dayNumber {
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    NSInteger day = [weekdayComponents weekday];
    return  day - 1;
}

@end
