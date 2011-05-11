//
//  LoginService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 28/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "LoginService.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "AuthenticationResponse.h"

@implementation LoginService

@synthesize delegate;

-(id) initWithDelegate:(id<LoginServiceDelegate>) serviceDelegate {
    self = [super init];
    if (self) {
        delegate = serviceDelegate;
    }
    return self;
}

//-(void) logout {
//    urlString = @"http://monkey.elhideout.org/users/sign_out";
//}

-(void) loginWith:(NSString *)username andPassword:(NSString *)password {
    
    urlString = @"http://monkey.elhideout.org/users/sign_in.json";
    
    NSMutableDictionary *loginDictionary = [[NSMutableDictionary alloc] init];
    [loginDictionary setObject:username forKey:@"login"];
    [loginDictionary setObject:password forKey:@"password"];
    
    [jsonDictionary setObject:loginDictionary forKey:@"user"];
    [loginDictionary release];
    [self performRequest];
}

-(void) performRequest {
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    NSString *json = [jsonDictionary JSONRepresentation];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSDictionary *responseDictionary = [[request_passed responseString] JSONValue];
    AuthenticationResponse *response = [[AuthenticationResponse alloc] initWithDicationary:responseDictionary];
    [delegate loginComplete:response];
    request = nil;
    
}
- (void)dealloc {
    [request release];
    [super dealloc];
}

@end
