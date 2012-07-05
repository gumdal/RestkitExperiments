//
//  RKFootball.m
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKFootball.h"

@implementation RKFootball
@synthesize title = title_;
@synthesize itemArray = itemArray_;

- (void)dealloc
{
    [self setTitle:nil];
    [self setItemArray:nil];
}

+(RKObjectMapping*)objectMap
{
    RKObjectMapping *footballMapping = [RKObjectMapping mappingForClass:[RKFootball class]];
    [footballMapping mapKeyPath:@"title" toAttribute:@"title"];
    return footballMapping;
}

@end
