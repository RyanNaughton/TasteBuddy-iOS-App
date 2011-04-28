//
//  PhotoUploadService.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ASIFormDataRequest;

@interface PhotoUploadService : NSObject {
    ASIFormDataRequest *request;
    id delegate;
}

@property (nonatomic, retain) ASIFormDataRequest *request;
@property (nonatomic, retain) id delegate;

-(void) uploadImage:(UIImage *)image withWhere:(NSString *)where andWhat:(NSString *)what andComments:(NSString *)comments andFacebook:(BOOL)facebookBOOL andDelegate:(id)delegate_passed;

@end
