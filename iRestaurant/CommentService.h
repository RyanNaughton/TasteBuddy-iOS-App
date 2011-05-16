//
//  CommentService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 16/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"
@class Restaurant;
@class MenuItem;

@protocol CommentServiceDelegate <NSObject>
-(void) doneCommenting:(NSDictionary *) status;
@end


@interface CommentService : AbstractService {
    id <CommentServiceDelegate> delegate; 
}

@property (nonatomic, retain) id <CommentServiceDelegate> delegate;

-(id) initWithDelegate:(id <CommentServiceDelegate>) commentDelegate;

-(void) commentOnRestaurant:(Restaurant *) restaurant withComment:(NSString *) text;
-(void) commentOnMenuItem:(MenuItem *) menuItem withComment:(NSString *) text;

@end
