//
//  SearchService.h
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Restaurant;

@protocol SearchServiceDelegate <NSObject>
-(void)searchFinished:(NSMutableArray *)restaurantsArray;
@end

@interface SearchService : NSObject {
    CGPoint location;
    id <SearchServiceDelegate> delegate;
    
}

@property (nonatomic,assign) CGPoint location;
@property (nonatomic, retain) id <SearchServiceDelegate> delegate;

//CLLocationCoordinate2D

-(id) initWithLocation:(CGPoint)current_location withDelegate:(id<SearchServiceDelegate>)searchServiceDelegate;
-(void)searchByTerm:(NSString *)term andNear:(NSString *)nearString;
-(void)searchByTerm:(NSString *)term;


@end
