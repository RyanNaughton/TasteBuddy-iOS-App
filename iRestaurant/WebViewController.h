//
//  WebViewController.h
//  iRestaurant
//
//  Created by Andrew Chalkley on 11/05/2011.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController {
    IBOutlet UIWebView *webview;
    NSString *urlAddress;
}

@property (nonatomic, retain) IBOutlet UIWebView *webview;
@property (nonatomic, retain) NSString *urlAddress;
@end
