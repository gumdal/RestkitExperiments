//
//  RKFootball.m
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKFootball.h"
#import "RKFootballItem.h"


@implementation RKFootball

@dynamic title;
@dynamic itemArray;
@dynamic lastBuildDate;
@dynamic guid;

- (void)dealloc
{
//    [self setTitle:nil];
//    [self setItemArray:nil];
//    [self setLastBuildDate:nil];
}

+(RKManagedObjectMapping*)objectMapForObjectStore:(RKManagedObjectStore*)inManagedObjectStore
{
    RKManagedObjectMapping *footballMapping = [RKManagedObjectMapping mappingForClass:[RKFootball class]
                                                                 inManagedObjectStore:inManagedObjectStore];
    [footballMapping mapKeyPath:@"title" toAttribute:@"title"];
    [footballMapping mapKeyPath:@"lastBuildDate" toAttribute:@"lastBuildDate"];
    [footballMapping setPrimaryKeyAttribute:@"guid"]; // http://restkit.org/api/master/Classes/RKManagedObjectMapping.html#//api/name/primaryKeyAttribute
    return footballMapping;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"\nTitle = %@\nLast Build date = %@", self.title, self.lastBuildDate];
}

@end
