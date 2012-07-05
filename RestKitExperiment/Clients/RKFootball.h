//
//  RKFootball.h
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKBaseObject.h"

@interface RKFootball : RKBaseObject
{
    NSString *title_;
    NSArray *itemArray_;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray *itemArray;

@end
