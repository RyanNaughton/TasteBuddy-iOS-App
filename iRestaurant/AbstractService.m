//
//  AbstractService.m
//  iRestaurant
//
//  Created by Andrew Chalkley on 07/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import "AbstractService.h"


@implementation AbstractService

@synthesize request;

- (void)dealloc {
    [request release];
    [super dealloc];
}

@end
