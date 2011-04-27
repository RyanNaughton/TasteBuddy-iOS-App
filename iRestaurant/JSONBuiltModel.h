//
//  JSONBuiltModel.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 27/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONBuiltModelProtocol <NSObject>
    -(void) checkForNullStrings;
@end


@interface JSONBuiltModel : NSObject {
    
}

-(void) checkForNull:(NSString *)stringToCheck;

@end
