//
//  RKFootballItem.m
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKFootballItem.h"


@implementation RKFootballItem

@dynamic commentsURL;
@dynamic link;
@dynamic publicationDate;
@dynamic storyDescription;
@dynamic title;

+(RKManagedObjectMapping*)objectMapForObjectStore:(RKManagedObjectStore*)inManagedObjectStore
{
    RKManagedObjectMapping *storyMapping = [RKManagedObjectMapping mappingForClass:[RKFootballItem class]
                                                              inManagedObjectStore:inManagedObjectStore];
    [storyMapping mapKeyPath:@"title" toAttribute:@"title"];
    [storyMapping mapKeyPath:@"link" toAttribute:@"link"];
    [storyMapping mapKeyPath:@"description" toAttribute:@"storyDescription"];
    [storyMapping mapKeyPath:@"comments" toAttribute:@"commentsURL"];
    return storyMapping;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"----------\nTitle - %@\nLink - %@\nComments URL - %@\n----------\n\n",self.title, self.link, self.commentsURL];
}


@end
