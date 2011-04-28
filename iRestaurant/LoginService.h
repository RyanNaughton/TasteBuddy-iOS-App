//
//  LoginService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIFormDataRequest;
@class AuthenticationResponse;

@protocol LoginServiceDelegate <NSObject>
    -(void) loginComplete:(AuthenticationResponse *)authToken;
@end

@interface LoginService : NSObject {
    id<LoginServiceDelegate> delegate;
    ASIFormDataRequest *request;
}

@property (nonatomic, retain) ASIFormDataRequest *request;
@property (nonatomic, retain) id<LoginServiceDelegate> delegate;


-(id) initWithDelegate:(id<LoginServiceDelegate>) serviceDelegate;
-(void) loginWith:(NSString *)username andPassword:(NSString *)password;

@end
