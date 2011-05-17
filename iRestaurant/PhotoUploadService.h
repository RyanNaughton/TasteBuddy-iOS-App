//
//  PhotoUploadService.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/27/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@class ASIFormDataRequest;
@protocol PhotoUploadServiceDelegate <NSObject> 
-(void) imageLoadingDone:(NSDictionary *)dict;
@end
@interface PhotoUploadService : AbstractService {
    id<PhotoUploadServiceDelegate> delegate;
}

@property (nonatomic, retain) id<PhotoUploadServiceDelegate> delegate;

-(void) uploadImage:(UIImage *)image withWhere:(NSString *)where andWhat:(NSString *)what andComments:(NSString *)comments andFacebook:(BOOL)facebookBOOL andDelegate:(id<PhotoUploadServiceDelegate>)delegate_passed andRestaurantId:(NSString *) restaurant_id andMenuItemId:(NSString *) menu_item_id;

@end
