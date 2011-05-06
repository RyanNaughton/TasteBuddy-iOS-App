//
//  TagService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIFormDataRequest;

@protocol TagServiceDelegate <NSObject> 
    -(void) tagsRetrieved:(NSMutableArray *) tags;
@end

@interface TagService : NSObject {
    id<TagServiceDelegate> delegate;
    ASIFormDataRequest *request;
}

@property (nonatomic, retain) id<TagServiceDelegate> delegate;
@property (nonatomic, retain) ASIFormDataRequest *request;

-(id) initWithDelegate:(id<TagServiceDelegate>) serviceDelegate;
-(void) getTags;

@end
