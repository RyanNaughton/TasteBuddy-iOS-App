//
//  hours.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 13/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Hours : NSObject {
    NSMutableArray *firstOpeningHours;
    NSMutableArray *secondOpeningHours;
    NSMutableArray *openingTimesCount;
}

@property (nonatomic, retain) NSMutableArray *firstOpeningHours;
@property (nonatomic, retain) NSMutableArray *secondOpeningHours;
@property (nonatomic, retain) NSMutableArray *openingTimesCount;


-(id) initWithArray:(NSArray *) hoursArray;

-(NSString *) todaysFirstOpeningHours;
-(NSString *) todaysSecondOpeningHours;
-(int) dayNumber;
-(int) todaysOpeningTimesCount;

@end
