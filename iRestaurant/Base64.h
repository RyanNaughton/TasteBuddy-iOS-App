//
//  Base64.h
//  mlightning
//
//  Created by Brendan Adkins on 2/15/11.
//  Copyright 2011 Development Now. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Base64 : NSObject {
	
}

+ (NSString *)encodeBase64WithString:(NSString *)strData;
+ (NSString *)encodeBase64WithData:(NSData *)objData;
+ (NSData *)decodeBase64WithString:(NSString *)strBase64;

@end
