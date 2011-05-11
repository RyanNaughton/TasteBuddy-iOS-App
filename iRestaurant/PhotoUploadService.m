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
    
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imageBase64String = [Base64 encodeBase64WithData:imageData];
        
    //NSString *json = [NSString stringWithFormat:@"{\"auth_token\": \"%@\", \"picture\" : {\"location_description\": \"%@\", \"content_description\": \"%@\", \"attachment\": \"%@\"}}", authToken, where, what, imageBase64String];
        
    NSString *urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/pictures/"];    
    NSURL *url = [NSURL URLWithString:urlString];
//    request = [ASIHTTPRequest requestWithURL:url];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
    [request setPostValue:where forKey:@"picture[location_description]"];
    [request setPostValue:what forKey:@"picture[content_description]"];
    
    //[request setPostValue:imageBase64String forKey:@"picture[attachment]"];
    
    [request addData:imageData withFileName:@"updloadedimage.png" andContentType:@"image/png" forKey:@"picture[attachment]"];
    
    
    [request setPostValue:@"4d776a379a16856d080000cb" forKey:@"picture[restaurant_id]"];
    [request setPostValue:@"" forKey:@"picture[menu_item_id]"];
    [request setPostValue:[self authToken] forKey:@"auth_token"];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

-(void) performRequest {
    #warning TODO move the upload in here
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
