//
//  TagService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 05/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"


@protocol TagServiceDelegate <NSObject> 
    -(void) tagsRetrieved:(NSMutableArray *) tags;
@end

@interface TagService : AbstractService {
    id<TagServiceDelegate> delegate;
}

@property (nonatomic, retain) id<TagServiceDelegate> delegate;

-(id) initWithDelegate:(id<TagServiceDelegate>) serviceDelegate;
-(void) getTags;

@end
