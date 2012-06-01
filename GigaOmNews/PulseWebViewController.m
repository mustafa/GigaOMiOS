//
//  PulseWebViewController.m
//  GigaOmNews
//
//  Created by Mustafa Furniturewala on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PulseWebViewController.h"
#import "PulseHeadLine.h"

@interface PulseWebViewController ()

@end

@implementation PulseWebViewController
@synthesize webView = _webView;
@synthesize headline = _headline;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL* url = [[NSURL alloc] initWithString:self.headline.contentUrl];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [[self webView] loadRequest:urlRequest];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
