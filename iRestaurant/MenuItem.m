//
//  MenuItem.m
//  iRestaurant
//
//  Created by Josh Timonen on 4/12/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "MenuItem.h"
#import "Comment.h"
#import "Tag.h"
#import "Rating.h"

#warning TODO remove this when API updates
#import "JSON.h"

@implementation MenuItem

@synthesize _id;
@synthesize name;
@synthesize tags;
@synthesize photo_urls;
@synthesize comments;
@synthesize pictures;
@synthesize restaurant_id;
@synthesize price;
@synthesize tags_text;
@synthesize rating;

-(id) init {
    self = [super init];
    if (self) {
        // custom init
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *)menuItemDictionary {
    self = [super init];
    if (self) {
        // custom init
        _id             = [[menuItemDictionary objectForKey:@"id"] retain];
        name            = [[menuItemDictionary objectForKey:@"name"] retain];
        photo_urls      = [[menuItemDictionary objectForKey:@"photo_urls"] retain];
        pictures        = [[menuItemDictionary objectForKey:@"pictures"] retain];
        restaurant_id   = [[menuItemDictionary objectForKey:@"restaurant_id"] retain];
        
        rating = [[Rating alloc] initWithUserRating:[menuItemDictionary objectForKey:@"user_rating"] andAverageRating:[menuItemDictionary objectForKey:@"average_rating"] andRatingsCount:[menuItemDictionary objectForKey:@"ratrings_count"]];
        

        
        NSNumber *priceFromDictionary = [[menuItemDictionary objectForKey:@"price"] retain];

        if([priceFromDictionary isKindOfClass:[NSNull class]]) {
            price = @"--.--";
        } else {
            price = [[NSString stringWithFormat:@"%@", priceFromDictionary] retain];    
        }
        [priceFromDictionary release];

        comments        = [[NSMutableArray alloc] init];

        tags = [[NSMutableArray alloc] init];
        NSDictionary *tagDictionary = [menuItemDictionary objectForKey:@"tags"];
        
        tags_text = [[[tagDictionary allKeys] componentsJoinedByString:@", "] retain];
        
        if (![tagDictionary isKindOfClass:[NSNull class]]) {
            for(NSString *key in [tagDictionary allKeys]) {
                Tag *tag = [[Tag alloc] initWithTagValue:key andCount:[[tagDictionary valueForKey:key] intValue]];
                [tags addObject:tag];
                [tag release];
            }
        }
        
        NSArray * user_tags = [[menuItemDictionary objectForKey:@"user_tags"] retain];
        
        if (![user_tags isKindOfClass:[NSNull class]]) {
            for (Tag *tag in tags) {
                tag.isUserTag = [user_tags containsObject:tag.name];
            }
        }
        [user_tags release];
        
        # warning Code here needs to be changed when API updates.
        //Actual array [menuItemDictionary objectForKey:@"comments"]
        NSString *tempJson = @"[{\"text\": \"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut leo sapien, sodales ac bibendum a, pretium eu nisi. Pellentesque eleifend lacus vel elit blandit ultricies. Donec vitae malesuada ipsum. Pellentesque augue dui, condimentum ac egestas vitae, ullamcorper vel nulla. In dapibus lorem sed sapien accumsan in gravida dui tempus. Sed bibendum volutpat leo, ac consectetur lectus luctus et. Nam enim odio, iaculis id placerat ac, semper in ante. Morbi luctus felis quis lectus porta ut molestie purus pellentesque. Pellentesque urna libero, interdum vel faucibus non, ullamcorper a arcu. Nam sollicitudin sagittis vehicula. Curabitur fermentum ipsum sem. Nunc hendrerit nunc at ante fringilla euismod. Morbi mattis magna vitae orci feugiat non aliquet arcu bibendum. Quisque ornare sodales dolor eu viverra. Maecenas vehicula ipsum eget turpis iaculis non euismod nisi malesuada.Maecenas vestibulum eleifend egestas. Pellentesque vitae erat turpis. Praesent in quam mi, non cursus metus.\", \"user_name\": \"Clark\", \"user_id\": \"456789\"}, {\"text\": \"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut leo sapien, sodales ac bibendum a, pretium eu nisi. Pellentesque eleifend lacus vel elit blandit ultricies. Donec vitae malesuada ipsum. Pellentesque augue dui. Maecenas vehicula ipsum eget turpis iaculis non euismod nisi malesuada.Maecenas vestibulum eleifend egestas. Pellentesque vitae erat turpis. Praesent in quam mi, non cursus metus.\", \"user_name\": \"Clark\", \"user_id\": \"456789\"}]";
        NSArray *temporaryArrayOfComments = [tempJson JSONValue];

        for (NSDictionary *commentDictionary in temporaryArrayOfComments) /* [menuItemDictionary objectForKey:@"comments"] */
        {
            Comment *comment = [[Comment alloc] initWithDictionary:commentDictionary];
            [comments addObject:comment];
            [comment release];
        }
    }
    return self;
}

-(void)dealloc {
    [_id            release];
    [name           release];
    [rating         release];
    [tags           release];
    [photo_urls     release];
    [comments       release];
    [pictures       release];
    [restaurant_id  release];
    [price          release];
    [tags_text      release];
    [super          dealloc];
}

@end
