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
@dynamic itemContent;

+(RKManagedObjectMapping*)objectMapForObjectStore:(RKManagedObjectStore*)inManagedObjectStore
{
    RKManagedObjectMapping *storyMapping = [RKManagedObjectMapping mappingForClass:[RKFootballItem class]
                                                              inManagedObjectStore:inManagedObjectStore];
    [storyMapping mapKeyPath:@"title" toAttribute:@"title"];
    [storyMapping mapKeyPath:@"link" toAttribute:@"link"];
    [storyMapping mapKeyPath:@"description" toAttribute:@"storyDescription"];
    [storyMapping mapKeyPath:@"comments" toAttribute:@"commentsURL"];
    [storyMapping mapKeyPath:@"content:encoded" toAttribute:@"itemContent"];
    return storyMapping;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"----------\nTitle - %@\nLink - %@\nComments URL - %@\nItem Content - %@\n----------\n\n",self.title, self.link, self.commentsURL, self.itemContent];
}

- (id)initWithEntity:(NSEntityDescription*)entity insertIntoManagedObjectContext:(NSManagedObjectContext*)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self != nil)
    {
        // Perform additional initialization.
        // Lets start observing for any changes on itemContent property
        [self addObserver:self
               forKeyPath:@"itemContent"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([@"itemContent" isEqualToString:keyPath])
    {
        
    }
}

- (void)dealloc
{
    [self removeObserver:self
              forKeyPath:@"itemContent"];
}

@end
