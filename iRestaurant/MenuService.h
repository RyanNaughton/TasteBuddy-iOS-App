//
//  MenuService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 15/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIFormDataRequest;
@class ASIHTTPRequest;

@class Menu;
@class Restaurant;

@protocol MenuServiceDelegate <NSObject>
    -(void)menuReturned:(Menu *)menu;
@end

@interface MenuService : NSObject {
    id<MenuServiceDelegate> delegate;
    ASIHTTPRequest *request;
}

@property (nonatomic, retain) id<MenuServiceDelegate> delegate;
@property (nonatomic, retain) ASIHTTPRequest *request;

-(id) initWithDelegate:(id <MenuServiceDelegate>) menuDelegate;

-(void) getMenuForRestaurant:(Restaurant *)restaurant;


@end
