//
//  MBJSONRequest.m
//  MBRequest
//
//  Created by Sebastian Celis on 3/4/12.
//  Copyright (c) 2012 Mobiata, LLC. All rights reserved.
//

#import "MBJSONRequest.h"

#import "MBBaseRequestSubclass.h"
#import "MBJSON.h"

@interface MBJSONRequest ()
@property (atomic, retain, readwrite) id responseJSON;
@property (nonatomic, copy, readwrite) MBRequestJSONCompletionHandler JSONCompletionHandler;
@end


@implementation MBJSONRequest

@synthesize JSONCompletionHandler = _JSONCompletionHandler;
@synthesize responseJSON = _responseJSON;

#pragma mark - Object Lifecycle

- (id)init
{
    if ((self = [super init]))
    {
        NSSet *types = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        [[self connectionOperation] setValidContentTypes:types];
    }

    return self;
}

- (void)dealloc
{
    [_JSONCompletionHandler release];
    [_responseJSON release];
    [super dealloc];
}

#pragma mark - Request

- (void)performJSONRequest:(NSURLRequest *)request completionHandler:(MBRequestJSONCompletionHandler)completionHandler
{
    [[self connectionOperation] setRequest:request];
    [self setJSONCompletionHandler:completionHandler];
    [self scheduleOperation];
}

#pragma mark - Response

- (void)parseResults
{
    [super parseResults];

    if ([self error] == nil)
    {
        NSError *error = nil;
        id obj = MBJSONObjectFromData([[self connectionOperation] responseData], &error);
        if (obj != nil)
        {
            [self setResponseJSON:obj];
        }
        else
        {
            [self setError:error];
        }
    }
}

- (void)notifyCaller
{
    [super notifyCaller];

    if ([self JSONCompletionHandler] != nil)
    {
        [self JSONCompletionHandler]([self responseJSON], [self error]);
    }
}

@end
