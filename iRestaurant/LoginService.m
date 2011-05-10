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

-(void) loginWith:(NSString *)username andPassword:(NSString *)password {
    
    if (request != nil) {
        [request cancel];
        request = nil;
    }
    
    NSString *json = [NSString stringWithFormat:@"{'user' : { 'login' : '%@', 'password' : '%@'}}", username, password];
    
    NSURL *url = [NSURL URLWithString:@"http://monkey.elhideout.org/users/sign_in.json"];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request startSynchronous];

}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSDictionary *responseDictionary = [[request_passed responseString] JSONValue];
    AuthenticationResponse *response = [[AuthenticationResponse alloc] initWithDicationary:responseDictionary];
    [response autorelease];
    [delegate loginComplete:response];
    request = nil;
    
}
- (void)dealloc {
    [request release];
    [super dealloc];
}

@end
