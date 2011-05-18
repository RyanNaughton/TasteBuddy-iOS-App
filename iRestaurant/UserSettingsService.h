//
//  UserSettingsService.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/17/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"
@class AuthenticationResponse;

@protocol UserSettingsServiceDelegate <NSObject>
-(void) settingsUpdateComplete;
@end

@interface UserSettingsService : AbstractService {
    id<UserSettingsServiceDelegate> delegate;
}

@property (nonatomic, retain) id<UserSettingsServiceDelegate> delegate;

-(void)updateWithUsername:(NSString *)username 
             andFirstName:(NSString *)firstName 
              andLastName:(NSString *)lastName 
              andPassword:(NSString *)password 
             andConfirmPW:(NSString *)confirmPW 
               andCountry:(NSString *)country 
            andPostalCode:(NSString *)postalCode 
                 andEmail:(NSString *)email 
             andBirthdate:(NSString *)birthdate;

-(id) initWithDelegate:(id<UserSettingsServiceDelegate>) serviceDelegate;


@end
