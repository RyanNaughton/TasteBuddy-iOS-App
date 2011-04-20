//
//  MenuSubsectionService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 20/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIFormDataRequest;
@class MenuSubsection;
@class Restaurant;

@protocol MenuSubsectionServiceDelegate <NSObject>
    -(void)menuSubsectionReturned:(MenuSubsection *) menuSubsection;
@end

@interface MenuSubsectionService : NSObject {
    ASIFormDataRequest *request;
    id<MenuSubsectionServiceDelegate> delegate;
}

@property (nonatomic, retain) id<MenuSubsectionServiceDelegate> delegate;
@property (nonatomic, retain) ASIFormDataRequest *request;

-(id) initWithDelegate:(id <MenuSubsectionServiceDelegate>) menuSubsectionDelegate;
-(void) getMenuSubsectionForRestaurant:(Restaurant *)restaurant withSection:(NSString *)section;

@end
