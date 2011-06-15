//
//  FestivalsService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/06/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"



@protocol FestivalsServiceDelegate <NSObject> 
    -(void) festivalsRetrieved:(NSMutableArray *) festivals;
@end

@interface FestivalsService : AbstractService {
    id<FestivalsServiceDelegate> delegate;
}

@property (nonatomic, retain) id<FestivalsServiceDelegate> delegate;

-(id) initWithDelegate:(id<FestivalsServiceDelegate>) serviceDelegate;
-(void) getFestivals;

@end
