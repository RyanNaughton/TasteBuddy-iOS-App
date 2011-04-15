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

@protocol MenuServiceDelegate <NSObject>
    -(void)menuReturned:(NSArray *)termsArray;
@end

@interface MenuService : NSObject {
    
}

@end
