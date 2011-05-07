//
//  MenuService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@class ASIFormDataRequest;

@class Menu;
@class Restaurant;

@protocol MenuServiceDelegate <NSObject>
    -(void)menuReturned:(Menu *)menu;
@end

@interface MenuService : AbstractService {
    id<MenuServiceDelegate> delegate;
}

@property (nonatomic, retain) id<MenuServiceDelegate> delegate;

-(id) initWithDelegate:(id <MenuServiceDelegate>) menuDelegate;

-(void) getMenuForRestaurant:(Restaurant *)restaurant;


@end
