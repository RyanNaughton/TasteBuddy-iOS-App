//
//  UserCreationService.m
//  iRestaurant
//
//  Created by Josh Timonen on 5/13/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "UserCreationService.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "AuthenticationResponse.h"

@implementation UserCreationService

@synthesize delegate;

-(id) initWithDelegate:(id<UserCreationServiceDelegate>) serviceDelegate {
    self = [super init];
    if (self) {
        delegate = serviceDelegate;
    }
    return self;
}

-(void)signUpWithUsername:(NSString *)username 
             andFirstName:(NSString *)firstName 
              andLastName:(NSString *)lastName 
              andPassword:(NSString *)password 
             andConfirmPW:(NSString *)confirmPW 
               andCountry:(NSString *)country 
            andPostalCode:(NSString *)postalCode 
                 andEmail:(NSString *)email 
             andBirthdate:(NSString *)birthdate
{
    
    urlString = @"http://monkey.elhideout.org/users.json";
    
    NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc] init];
    [userDictionary setObject:username forKey:@"username"];
    [userDictionary setObject:firstName forKey:@"first_name"];
    [userDictionary setObject:lastName forKey:@"last_name"];
    [userDictionary setObject:password forKey:@"password"];
    [userDictionary setObject:confirmPW forKey:@"password_confirmation"];
    [userDictionary setObject:country forKey:@"country"];
    [userDictionary setObject:postalCode forKey:@"postal_code"];
    [userDictionary setObject:email forKey:@"email"];
    if(![birthdate isEqualToString:@"--"]) {
        [userDictionary setObject:birthdate forKey:@"birthday"];
    }
    [jsonDictionary setObject:userDictionary forKey:@"user"];
    [userDictionary release];
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
    if ([responseDictionary objectForKey:@"authentication_token"]) {
        // success
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"SUCCESS!" message:@"You have successfully signed up for TasteBuddy!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        AuthenticationResponse *response = [[AuthenticationResponse alloc] initWithDicationary:responseDictionary];
        [delegate signupComplete:response];
    } else {
        // errors
        NSString *errorMessagesAll = @"";
        NSString *errorName;
        NSString *errorMessage = @"";
        for (id key in responseDictionary) {
            errorName = [NSString stringWithFormat:@"%@", key];
            
            NSArray *errorMessageArray = [responseDictionary objectForKey:key];
            for (NSString *errorMessageString in errorMessageArray) {
                if ([errorMessage isEqualToString:@""]) {
                    errorMessage = [NSString stringWithFormat:@"%@", errorMessageString];
                } else {
                    errorMessage = [NSString stringWithFormat:@"%@, %@", errorMessage, errorMessageString];
                }
            }

            if ([errorMessagesAll isEqualToString:@""]) {
                errorMessagesAll = [NSString stringWithFormat:@"%@: %@", errorName, errorMessage];
            } else {
                errorMessagesAll = [NSString stringWithFormat:@"%@ \n %@: %@", errorMessagesAll, errorName, errorMessage];
            }
            errorMessage = @"";
        
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:errorMessagesAll delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        [alert release];

    }
    request = nil;
}
- (void)dealloc {
    [request release];
    [super dealloc];
}

@end
