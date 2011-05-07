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
}

@property (nonatomic, retain) ASIFormDataRequest *request;

@end
