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
#import "JSON.h"

@implementation PhotoUploadService
@synthesize delegate;

-(void) uploadImage:(UIImage *)image withWhere:(NSString *)where andWhat:(NSString *)what andComments:(NSString *)comments andFacebook:(BOOL)facebookBOOL andDelegate:(id<PhotoUploadServiceDelegate>)delegate_passed andRestaurantId:(NSString *)restaurant_id andMenuItemId:(NSString *) menu_item_id
{
    authTokenRequired = YES;
    delegate = delegate_passed;
    urlString = [NSString stringWithFormat:@"http://monkey.elhideout.org/pictures.json"];    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8f);
    
    [jsonDictionary setObject:comments forKey:@"comments"];
    [jsonDictionary setObject:imageData forKey:@"imageData"];
    

    [jsonDictionary setObject:restaurant_id forKey:@"restaurant_id"];
    
    if (menu_item_id) {
        [jsonDictionary setObject:menu_item_id forKey:@"menu_item_id"];
    }
    
    [self prepareRequest];
}

-(void) performRequest {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startLoadingIndicator" object:nil];
    NSURL *url = [NSURL URLWithString:urlString];
        
    request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
    
    [request addData:[jsonDictionary objectForKey:@"imageData"] withFileName:@"updloadedimage.jpg" andContentType:@"image/jpg" forKey:@"picture[attachment]"];
    
    [request setPostValue:[jsonDictionary objectForKey:@"comments"] forKey:@"picture[caption]"];
    [request setPostValue:[jsonDictionary objectForKey:@"restaurant_id"] forKey:@"picture[restaurant_id]"];
    
    if(![[jsonDictionary objectForKey:@"menu_item_id"] isKindOfClass:[NSNull class]]){
        [request setPostValue:[jsonDictionary objectForKey:@"menu_item_id"] forKey:@"picture[menu_item_id]"];
    }
    [request setPostValue:[jsonDictionary objectForKey:@"auth_token"] forKey:@"auth_token"];
    [request setDelegate:self];
    [request setUseCookiePersistence:NO];
    [request startAsynchronous];
    
    NSLog(@"menu item id: %@ | restaurant id: %@", [jsonDictionary objectForKey:@"menu_item_id"], [jsonDictionary objectForKey:@"restaurant_id"]);
}

-(void) dealloc
{
    [delegate release];
    [super dealloc];
}

- (void)requestFinished:(ASIHTTPRequest *)request_passed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stopLoadingIndicator" object:nil];
    NSString *responseString = [request_passed responseString];
    NSDictionary *dict = [responseString JSONValue];
    // need to setup a delegate protocol..
    [delegate imageLoadingDone:dict];
    request = nil;
}

@end
