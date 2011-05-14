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

-(void) uploadImage:(UIImage *)image withWhere:(NSString *)where andWhat:(NSString *)what andComments:(NSString *)comments andFacebook:(BOOL)facebookBOOL andDelegate:(id<PhotoUploadServiceDelegate>)delegate_passed andRestaurantId:(NSString *)restaurant_id andMenuItemId:(NSString *) menu_item_id
{
    
    NSLog(@"restaurant id: %@", restaurant_id);
    authTokenRequired = YES;
    delegate = delegate_passed;
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/pictures.json"];    
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    [jsonDictionary setObject:where forKey:@"where"];
    [jsonDictionary setObject:what forKey:@"what"];
    [jsonDictionary setObject:imageData forKey:@"imageData"];
    [jsonDictionary setObject:restaurant_id forKey:@"restaurant_id"];
    [jsonDictionary setObject:menu_item_id forKey:@"menu_item_id"];
    
    
    [self prepareRequest];
}

-(void) performRequest {
    NSURL *url = [NSURL URLWithString:urlString];
    
    request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
    [request setPostValue:[jsonDictionary objectForKey:@"where"] forKey:@"picture[location_description]"];
    [request setPostValue:[jsonDictionary objectForKey:@"what"] forKey:@"picture[content_description]"];
    
    [request addData:[jsonDictionary objectForKey:@"imageData"] withFileName:@"updloadedimage.png" andContentType:@"image/png" forKey:@"picture[attachment]"];
    
    [request setPostValue:[jsonDictionary objectForKey:@"restaurant_id"] forKey:@"picture[restaurant_id]"];
    if(![[jsonDictionary objectForKey:@"menu_item_id"] isEqualToString:@""]){
    [request setPostValue:[jsonDictionary objectForKey:@"menu_item_id"] forKey:@"picture[menu_item_id]"];
    }
    [request setPostValue:[jsonDictionary objectForKey:@"auth_token"] forKey:@"auth_token"];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
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
