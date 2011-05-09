//
//  AbstractService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 07/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIFormDataRequest;


@interface AbstractService : NSObject {
    ASIFormDataRequest *request;
    bool authTokenRequired;
    bool authTokenOptional;
}

@property (nonatomic, retain) ASIFormDataRequest *request;
@property (nonatomic, assign) bool authTokenRequired;
@property (nonatomic, assign) bool authTokenOptional;

-(NSString *) authToken;
-(bool) isLoggedIn;
@end
