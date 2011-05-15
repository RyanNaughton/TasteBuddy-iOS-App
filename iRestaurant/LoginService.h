//
//  LoginService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@class AuthenticationResponse;

@protocol LoginServiceDelegate <NSObject>
    -(void) loginComplete:(AuthenticationResponse *)authToken;
    -(void) loginFailed;
@end

@interface LoginService : AbstractService {
    id<LoginServiceDelegate> delegate;
}

@property (nonatomic, retain) id<LoginServiceDelegate> delegate;


-(id) initWithDelegate:(id<LoginServiceDelegate>) serviceDelegate;
-(void) loginWith:(NSString *)username andPassword:(NSString *)password;

@end
