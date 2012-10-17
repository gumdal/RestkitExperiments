//
//  RKFootball.h
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RKBaseObject.h"

@class RKFootballItem;

@interface RKFootball : RKBaseObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *itemArray;
@property (nonatomic, retain) NSDate *lastBuildDate;
@end

@interface RKFootball (CoreDataGeneratedAccessors)

- (void)addItemArrayObject:(RKFootballItem *)value;
- (void)removeItemArrayObject:(RKFootballItem *)value;
- (void)addItemArray:(NSSet *)values;
- (void)removeItemArray:(NSSet *)values;
@end
