//
//  DealsService.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/31/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"
#import "ASIHTTPRequestDelegate.h"

@class ASIFormDataRequest;

@protocol DealsServiceDelegate <NSObject>
-(void) dealDataReturned:(NSDictionary *)dict;
@end

@interface DealsService : NSObject <ASIHTTPRequestDelegate> {
    id <DealsServiceDelegate> delegate;
    ASIFormDataRequest *request;
    NSMutableDictionary *jsonDictionary;
}

@property (nonatomic, retain) id <DealsServiceDelegate> delegate;
@property (nonatomic, retain) ASIFormDataRequest *request;
@property (nonatomic, retain) NSMutableDictionary *jsonDictionary;

-(id) initWithDelegate:(id <DealsServiceDelegate>) dealsDelegate;
-(void) getDeals;

@end
