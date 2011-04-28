//
//  AuthenticationResponse.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AuthenticationResponse : NSObject {
    NSString * authentication_token;
    NSString * _id;
    NSString * username;
    NSString * first_name;
    NSString * last_name;
}

@property (nonatomic, retain) NSString * authentication_token;
@property (nonatomic, retain) NSString * _id;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;

-(id) initWithDicationary:(NSDictionary *)responseDictionary;

@end
