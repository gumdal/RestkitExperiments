//
//  RKFootballItem.m
//  RestKitExperiment
//
//  Created by Raj Pawan Gumdal on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKFootballItem.h"

@implementation RKFootballItem
@synthesize title = title_;
@synthesize link = link_;
@synthesize commentsURL = commentsURL_;
@synthesize storyDescription = storyDescription_;
@synthesize publicationDate = publicationDate_;

- (void)dealloc
{
    [self setTitle:nil];
    [self setLink:nil];
    [self setCommentsURL:nil];
    [self setStoryDescription:nil];
    [self setPublicationDate:nil];
}

+(RKObjectMapping*)objectMap
{
    RKObjectMapping *storyMapping = [RKObjectMapping mappingForClass:[RKFootballItem class]];
    [storyMapping mapKeyPath:@"title" toAttribute:@"title"];
    [storyMapping mapKeyPath:@"link" toAttribute:@"link"];
    [storyMapping mapKeyPath:@"description" toAttribute:@"storyDescription"];
    [storyMapping mapKeyPath:@"comments" toAttribute:@"commentsURL"];
    return storyMapping;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"----------\nTitle - %@\nLink - %@\nDescription - %@\nComments URL - %@\n----------\n\n",self.title, self.link, self.storyDescription, self.commentsURL];
}

@end
