//
//  UserProfileService.h
//  iRestaurant
//
//  Created by Josh Timonen on 5/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@protocol UserProfileServiceDelegate <NSObject>
-(void) doneRetrievingProfile:(NSMutableDictionary *) profile;
@end

@interface UserProfileService : AbstractService {
    id <UserProfileServiceDelegate> delegate;
}

@property (nonatomic, retain) id <UserProfileServiceDelegate> delegate;

-(id) initWithDelegate:(id <UserProfileServiceDelegate>) profileDelegate;

-(void) getUserProfile;

@end
