//
//  AutocompleteService.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 14/04/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIFormDataRequest;
@class ASIHTTPRequest;

@protocol AutocompleteServiceDelegate <NSObject>
  -(void)autocompleteFinished:(NSArray *)termsArray;
@end

@interface AutocompleteService : NSObject {
    id <AutocompleteServiceDelegate> delegate;  
    ASIFormDataRequest *request;
    NSArray *values;
}

@property (nonatomic, retain) id <AutocompleteServiceDelegate> delegate;
@property (nonatomic, retain) ASIFormDataRequest *request;
@property (nonatomic, retain) NSArray *values;

-(id) initWithDelegate:(id <AutocompleteServiceDelegate>) serviceDelegate;
-(void) getTerms:(NSString *)term;
-(void) getPlaces:(NSString *)place;
-(void) requestFinished:(ASIHTTPRequest *)request_passed;


@end
