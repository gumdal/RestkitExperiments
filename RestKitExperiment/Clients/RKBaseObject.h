//
//  RKBaseObject.h
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Restkit/Restkit.h>

@interface RKBaseObject : NSManagedObject

+(RKManagedObjectMapping*)objectMapForObjectStore:(RKManagedObjectStore*)inManagedObjectStore;

@end
