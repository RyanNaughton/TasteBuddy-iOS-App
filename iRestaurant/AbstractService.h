//
//  AbstractService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 07/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"

@class ASIFormDataRequest;
@class iRestaurantAppDelegate;

@protocol AbstractServiceProtocol <NSObject>
    -(void) performRequest;
@end

@interface AbstractService : NSObject<ASIHTTPRequestDelegate, AbstractServiceProtocol> {
    iRestaurantAppDelegate *appDelegate;
    ASIFormDataRequest *request;
    bool authTokenRequired;
    bool authTokenOptional;
    NSMutableDictionary *jsonDictionary;
    NSString *urlString;
}

@property (nonatomic, retain) iRestaurantAppDelegate *appDelegate;
@property (nonatomic, retain) ASIFormDataRequest *request;
@property (nonatomic, retain) NSMutableDictionary *jsonDictionary;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, assign) bool authTokenRequired;
@property (nonatomic, assign) bool authTokenOptional;

-(NSString *) authToken;
-(bool) isLoggedIn;
-(void) prepareRequest;
-(void) logInFinished;
@end
