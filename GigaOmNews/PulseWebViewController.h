//
//  PulseWebViewController.h
//  GigaOmNews
//
//  Created by Mustafa Furniturewala on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PulseHeadLine;
@interface PulseWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) PulseHeadLine* headline;
@end
