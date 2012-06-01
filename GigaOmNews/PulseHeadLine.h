//
//  PulseHeadLine.h
//  GigaOmNews
//
//  Created by Mustafa Furniturewala on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PulseHeadLine : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString* imageURL;
@property (nonatomic,strong) NSString* contentUrl;

//designated initializer
-(id)initWithTitle:(NSString*) title imageForURL:(NSString*)image contentURL:(NSString*) content;
@end
