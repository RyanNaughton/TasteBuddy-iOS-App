//
//  Comment.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 22/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Comment : NSObject {
    NSString *user_id;
    NSString *user_name;
    NSString *text;
}

@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *user_name;
@property (nonatomic, retain) NSString *text;

-(id)initWithDictionary:(NSDictionary *) commentDictionary;

@end
