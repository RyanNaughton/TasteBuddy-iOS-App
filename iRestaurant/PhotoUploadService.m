//
//  PhotoUploadService.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "PhotoUploadService.h"
#import "ASIFormDataRequest.h"
#import "iRestaurantAppDelegate.h"
#import "Base64.h"

@implementation PhotoUploadService
@synthesize delegate;

-(void) uploadImage:(UIImage *)image withWhere:(NSString *)where andWhat:(NSString *)what andComments:(NSString *)comments andFacebook:(BOOL)facebookBOOL andDelegate:(id)delegate_passed 
{
    delegate = delegate_passed;
    
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *authToken = [appDelegate readSavedSetting:@"authentication_token"];
    NSData *imageData = UIImagePNGRepresentation(image);
    //NSString *imageBase64String = [Base64 encodeBase64WithData:imageData];
        
    //NSString *json = [NSString stringWithFormat:@"{\"auth_token\": \"%@\", \"picture\" : {\"location_description\": \"%@\", \"content_description\": \"%@\", \"attachment\": \"%@\"}}", authToken, where, what, imageBase64String];
        
    NSString *urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/pictures/"];    
    NSURL *url = [NSURL URLWithString:urlString];
//    request = [ASIHTTPRequest requestWithURL:url];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:where forKey:@"location_description"];
    [request setPostValue:what forKey:@"content_description"];
    [request setPostValue:imageData forKey:@"attachment"];
    [request setPostValue:authToken forKey:@"auth_token"];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

-(void) dealloc
{
    [delegate release];
    [super dealloc];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSString *responseString = [request_passed responseString];
    NSLog(@"response: %@", responseString);
    // need to setup a delegate protocol..
    [delegate imageLoadingDone];
    request = nil;
}


@end
