//
//  PulseRootViewController.m
//  GigaOmNews
//
//  Created by Mustafa Furniturewala on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PulseRootViewController.h"
#import "MBRequest.h"
#import "PulseHeadLine.h"
#import "PulseWebViewController.h"

@interface PulseRootViewController ()

@end

@implementation PulseRootViewController

@synthesize dataSource = _dataSource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // start getting the feed asynchronously
    // construct the request
    //  Next, we create an URL that points to the target endpoint
    NSURL *url = 
    [NSURL URLWithString:@"https://ajax.googleapis.com/ajax/services/feed/load?q=http://feeds.feedburner.com/ommalik&v=1.0"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    _dataSource = [[NSMutableArray alloc] init];
    MBJSONRequest *jsonRequest = [[MBJSONRequest alloc] init];
    [jsonRequest performJSONRequest:urlRequest completionHandler:^(id responseJSON, NSError *error) {
        if (error != nil)
        {
            NSLog(@"Error requesting GigaOM news    : %@", error);
        }
        else
        {
            NSString *header = [[[responseJSON objectForKey:@"responseData"] 
                                 objectForKey:@"feed"] 
                                objectForKey:@"title"];
            [[self navigationItem] setTitle:header];
            NSArray *entries = [[[responseJSON objectForKey:@"responseData"] 
                                objectForKey:@"feed"] 
                               objectForKey:@"entries"];
            for (NSDictionary *entry in entries)
            {
                NSString *title = [entry objectForKey:@"title"];
                NSString *author = [entry objectForKey:@"author"]; 
                NSString *link = [entry objectForKey:@"link"]; 
                
                // get the image url for the thumbnail
                NSArray *mediaGroups = [entry objectForKey:@"mediaGroups"];
                NSDictionary *dict = [mediaGroups objectAtIndex:0];
                NSArray *imageUrls = [dict objectForKey:@"contents"];
                NSDictionary *imageThumbnail = [imageUrls objectAtIndex:0];
                
                NSLog(@"'%@' by %@", title, author);
               // NSLog(@"Dictionary : %@",[imageThumbnail objectForKey:@"url"]);
                PulseHeadLine *headline = [[PulseHeadLine alloc] initWithTitle:title 
                                                                   imageForURL:[imageThumbnail objectForKey:@"url"] 
                                                                    contentURL:link];
                [[self dataSource] addObject:headline];
            }
        }
        [[self tableView] reloadData];
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self dataSource] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TitleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Display loading image while the actual images load
    [[cell imageView] setImage:[UIImage imageNamed:@"loading.jpeg"]];
    PulseHeadLine *headline = [[self dataSource] objectAtIndex:[indexPath row]];
    [[cell textLabel] setNumberOfLines:3];
    [[cell textLabel] setFont:[UIFont systemFontOfSize:15]];
    [[cell textLabel] setText:headline.title];
    NSURL *url = [NSURL URLWithString: 
                  headline.imageURL];
    NSURLRequest* imageURLRequest = [[NSURLRequest alloc] initWithURL:url];
    MBImageRequest* imageRequest = [[MBImageRequest alloc] init];
    
    // get the images asynchronously
    
    [imageRequest performImageRequest:imageURLRequest 
                    completionHandler:^(UIImage *image, NSError *error) {
        [[cell imageView] setImage:image];
    }];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // move to the web view and pass feed data
    if([[segue identifier] isEqualToString:@"TitleToWebView"])
    {
        
        PulseWebViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        PulseHeadLine* headline = [[self dataSource] objectAtIndex:[indexPath row]];
        [detailViewController setHeadline:headline];
        
        
    }
}

@end
