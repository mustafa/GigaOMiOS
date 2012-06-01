//
//  PulseHeadLine.m
//  GigaOmNews
//
//  Created by Mustafa Furniturewala on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PulseHeadLine.h"

@implementation PulseHeadLine

@synthesize title = _title;
@synthesize imageURL = _imageURL;
@synthesize contentUrl = _contentUrl;


//desginated initializer

-(id)initWithTitle:(NSString*) title imageForURL:(NSString*)image contentURL:(NSString*) content
{
    if(self = [super init])
    {
        [self setTitle:title];
        [self setImageURL:image];
        [self setContentUrl:content];
    }
    return  self;
}
@end
