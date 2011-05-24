//
//  RestaurantAnnotation.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 24/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "Restaurant.h"

@interface RestaurantAnnotation : NSObject <MKAnnotation> {
	
	CLLocationCoordinate2D coordinate; 
	NSString *title; 
	NSString *subtitle;
    Restaurant *restaurant;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, retain) Restaurant *restaurant;

-(id) initWithRestaurant:(Restaurant *) restaurantPassed;

@end
