//
//  UserAttributesService.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/17/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"
@class AuthenticationResponse;

@protocol UserAttributesServiceDelegate <NSObject>
-(void) attributesServiceComplete:(NSDictionary *)dict;
@end

@interface UserAttributesService : AbstractService {
    id <UserAttributesServiceDelegate> delegate;
}

@property (nonatomic, retain) id <UserAttributesServiceDelegate> delegate;

-(void) getUserData;

@end
