//
//  RKBaseObject.m
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKBaseObject.h"

@implementation RKBaseObject

+(RKObjectMapping*)objectMap
{
    NSAssert (NO, @"Subclasses should implement it and provide their own object mapping");
    return nil;
}

@end
