//
//  UserCreationService.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"
@class AuthenticationResponse;

@protocol UserCreationServiceDelegate <NSObject>
-(void) signupComplete:(AuthenticationResponse *)authToken;
@end

@interface UserCreationService : AbstractService {
    id<UserCreationServiceDelegate> delegate;
}

@property (nonatomic, retain) id<UserCreationServiceDelegate> delegate;

-(void)signUpWithUsername:(NSString *)username 
             andFirstName:(NSString *)firstName 
              andLastName:(NSString *)lastName 
              andPassword:(NSString *)password 
             andConfirmPW:(NSString *)confirmPW 
               andCountry:(NSString *)country 
            andPostalCode:(NSString *)postalCode 
                 andEmail:(NSString *)email 
             andBirthdate:(NSString *)birthdate;

-(id) initWithDelegate:(id<UserCreationServiceDelegate>) serviceDelegate;


@end
