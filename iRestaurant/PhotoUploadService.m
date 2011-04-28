//
//  PhotoUploadService.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "PhotoUploadService.h"
#import "ASIHTTPRequest.h"
#import "iRestaurantAppDelegate.h"

@implementation PhotoUploadService
@synthesize request, delegate;

-(void) uploadImage:(UIImage *)image withWhere:(NSString *)where andWhat:(NSString *)what andComments:(NSString *)comments andFacebook:(BOOL)facebookBOOL andDelegate:(id)delegate_passed 
{
    delegate = delegate_passed;
    
    iRestaurantAppDelegate *appDelegate = (iRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *authToken = [appDelegate readSavedSetting:@"authentication_token"];
    
    NSLog(@"auth token: %@", authToken);
    
    //NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    // NSString *imageDataStringBase64 = [imageData base64Encoding];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *attachment_file_name = @""; //[NSString stringWithFormat:@"%@-at-%@", what, where];
    
    NSString *json = [NSString stringWithFormat:@"{\"auth_token\": \"%@\", \"picture\" : {\"location_description\": \"%@\", \"content_description\": \"%@\", \"attachment_file_name\": \"%@\", \"attachment\": \"%@\"}}", authToken, where, what, attachment_file_name, imageData];
    
    NSLog(@"JSON: %@", json);
    
    NSString *urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/pictures/"];    
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void) dealloc
{
    [delegate release];
    [request release];
    [super dealloc];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    NSString *responseString = [request_passed responseString];
    NSLog(@"response: %@", responseString);
    
    // need to setup a delegate protocol..
    [delegate imageLoadingDone];
}


@end
