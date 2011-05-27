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
        
        if([hoursArray isKindOfClass:[NSNull class]]) {
            for (int i = 0; i < 7; i++) {
                [firstOpeningHours addObject:@"Call"];
                [secondOpeningHours addObject:@"-"];
                [openingTimesCount addObject:[NSNumber numberWithInt:1]];
            }
        } else {
        for (NSArray *daysHours in hoursArray) {
            [openingTimesCount addObject:[NSNumber numberWithInt:[daysHours count]]];

            NSDictionary *firstOpenHours = [[daysHours objectAtIndex:0] objectForKey:@"open"];
            NSDictionary *firstCloseHours = [[daysHours objectAtIndex:0] objectForKey:@"close"];
            
            // add extra zero if necessary
            NSString *firstOpenHoursMinutes;
            if ([[[firstOpenHours objectForKey:@"m"] stringValue] length] == 1) { 
                firstOpenHoursMinutes = [NSString stringWithFormat:@"%@0", [firstOpenHours objectForKey:@"m"]];
            } else {
                firstOpenHoursMinutes = [firstOpenHours objectForKey:@"m"];
            }
            NSString *firstCloseHoursMinutes;
            if ([[[firstCloseHours objectForKey:@"m"] stringValue] length] == 1) { 
                firstCloseHoursMinutes = [NSString stringWithFormat:@"%@0", [firstCloseHours objectForKey:@"m"]];
            } else {
                firstCloseHoursMinutes = [firstCloseHours objectForKey:@"m"];
            }
            
            [firstOpeningHours addObject:[NSString stringWithFormat:@"%@:%@ - %@:%@", [firstOpenHours objectForKey:@"h"], firstOpenHoursMinutes, [firstCloseHours objectForKey:@"h"], firstCloseHoursMinutes]];

            
            if([daysHours count] > 1) {
                NSDictionary *secondOpenHours = [[daysHours objectAtIndex:1] objectForKey:@"open"];
                NSDictionary *secondCloseHours = [[daysHours objectAtIndex:1] objectForKey:@"close"];
                
                // add extra zero if necessary
                NSString *secondOpenHoursMinutes;
                if ([[[secondOpenHours objectForKey:@"m"] stringValue] length] == 1) { 
                    secondOpenHoursMinutes = [NSString stringWithFormat:@"%@0", [secondOpenHours objectForKey:@"m"]];
                } else {
                    secondOpenHoursMinutes = [secondOpenHours objectForKey:@"m"];
                }
                NSString *secondCloseHoursMinutes;
                if ([[[secondCloseHours objectForKey:@"m"] stringValue] length] == 1) { 
                    secondCloseHoursMinutes = [NSString stringWithFormat:@"%@0", [secondCloseHours objectForKey:@"m"]];
                } else {
                    secondCloseHoursMinutes = [secondCloseHours objectForKey:@"m"];
                }
                
                [secondOpeningHours addObject:[NSString stringWithFormat:@"%@:%@ - %@:%@", [secondOpenHours objectForKey:@"h"], secondOpenHoursMinutes, [secondCloseHours objectForKey:@"h"], secondCloseHoursMinutes]];
                
            } else {
                [secondOpeningHours addObject:@"-"];
            }
            
            
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
